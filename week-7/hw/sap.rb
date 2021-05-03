require_relative '../../lib/queue.rb'

class SAPResult
  attr_reader :length, :ancestor, :path
  def initialize(length, ancestor, path)
    @length = length
    @ancestor = ancestor
    @path = path
  end
end

class SAP
  def initialize(graph)
    @graph = graph
  end

  def length(v, w)
    if v.is_a?(Numeric) && w.is_a?(Numeric)
      two_vertex_bfs(v, w).length
    elsif v.is_a?(Array) && w.is_a?(Array)
      two_vertex_set_bfs(v, w).length
    end
  end

  def path(v, w)
    if v.is_a?(Numeric) && w.is_a?(Numeric)
      two_vertex_bfs(v, w).path
    elsif v.is_a?(Array) && w.is_a?(Array)
      two_vertex_set_bfs(v, w).path
    end
  end

  def ancestor(v, w)
    if v.is_a?(Numeric) && w.is_a?(Numeric)
      two_vertex_bfs(v, w).ancestor
    else
      two_vertex_set_bfs(v, w).ancestor
    end
  end

  private

  def two_vertex_bfs(v, w)
    return SAPResult.new(0, v, [v]) if v == w

    distance_v = Array.new(@graph.v)
    distance_w = Array.new(@graph.v)
    
    q_v = Queue.new
    distance_v[v] = 0
    q_v.enqueue(v)
    
    q_w = Queue.new
    distance_w[w] = 0
    q_w.enqueue(w)

    while q_v.size > 0 || q_w.size > 0
      [
        [q_v, distance_v, distance_w], 
        [q_w, distance_w, distance_v]
      ].each do |q, d, other_d|
        if q.size > 0
          x = q.dequeue
          @graph.adj(x).each do |a|
            next if d[a]

            d[a] = d[x] + 1

            if other_d[a]
              return SAPResult.new(d[a] + other_d[a], a)
            end

            q.enqueue(a)
          end
        end
      end
    end
  end

  def two_vertex_set_bfs(v, w)
    distance_v = Array.new(@graph.v)
    edge_to_v = Array.new(@graph.v)

    distance_w = Array.new(@graph.v)
    edge_to_w = Array.new(@graph.v)

    q_v = Queue.new
    v.each do |x|
      q_v.enqueue(x)
      distance_v[x] = 0
      edge_to_v[x] = x
    end

    q_w = Queue.new
    w.each do |x|
      q_w.enqueue(x)
      distance_w[x] = 0
      edge_to_w[x] = x
      if distance_v[x]
        return SAPResult.new(0, x, [x])
      end
    end

    while q_v.size > 0 || q_w.size > 0
      [
        [q_v, distance_v, distance_w, edge_to_v], 
        [q_w, distance_w, distance_v, edge_to_w]
      ].each do |q, d, other_d, e|
        next if q.size == 0

        x = q.dequeue
        @graph.adj(x).each do |a|
          next if d[a]
          
          d[a] = d[x] + 1
          e[a] = x
          if other_d[a]
            path = construct_path(a, edge_to_v, edge_to_w)
            return SAPResult.new(d[a] + other_d[a], a, path)
          end
          q.enqueue(a)
        end
      end
    end
  end

  def construct_path(a, edge_to_v, edge_to_w) 
    path_to_v = []
    x = a
    while edge_to_v[x] != x
      path_to_v << x
      x = edge_to_v[x]
    end
    path_to_v << x

    path_to_w = []
    x = a
    while edge_to_w[x] != x
      path_to_w << x
      binding.pry if edge_to_w[x].nil?
      x = edge_to_w[x]
    end

    path_to_w << x
    [path_to_v, path_to_w]
  end
end