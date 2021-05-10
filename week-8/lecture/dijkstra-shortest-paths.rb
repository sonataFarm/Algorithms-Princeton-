require './indexed-min-pq'
require './edge-weighted-digraph'

class DijkstraSP
  def initialize(graph, source)
    @graph = graph
    @source = source

    analyze_shortest_paths
  end

  def analyze_shortest_paths
    @edge_to = Array.new(@graph.v)
    @dist_to = Array.new(@graph.v) { Float::INFINITY }

    @dist_to[@source] = 0.0

    @pq = IndexedMinPQ.new(@graph.v)
    @pq.insert(@source, 0.0)

    while @pq.any?
      min = @pq.del_min

      @graph.adj(min).each do |e|
        relax(e)
      end
    end
  end

  def relax(e)
    from, to = e.from, e.to
    distance_to_consider = @dist_to[from] + e.weight
    return unless distance_to_consider < @dist_to[to]
    
    @dist_to[to] = distance_to_consider
    @edge_to[to] = from

    if !@pq.contains?(to)
      @pq.insert(to, distance_to_consider)
    else
      @pq.change_key(to, distance_to_consider)
    end
  end

  def path_to(v)
    return [] if v == @source
    return nil if @edge_to[v].nil?

    path = []

    while v != @source
      path << v
      v = @edge_to[v]
    end

    path << @source

    path.reverse
  end

  def distance(v)
    @dist_to[v]
  end
end

g = EdgeWeightedDigraph.new(7)

g.add_edge(1, 0, 1.0)
g.add_edge(1, 3, 11.0)
g.add_edge(1, 5, 3.2)
g.add_edge(1, 2, 5.3)
g.add_edge(2, 6, 2.1)
g.add_edge(2, 3, 9.0)
g.add_edge(3, 4, 6.2)
g.add_edge(4, 2, 4.2)
g.add_edge(5, 2, 2.0)
g.add_edge(6, 4, 3.7)

sp = DijkstraSP.new(g, 1)

require 'pry'
binding.pry
