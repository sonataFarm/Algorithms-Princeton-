require '../../week-2/lecture/stacks_queues_bags/linked_queue_of_strings.rb'

# same as graph bfs!
class DigraphBFS
  def initialize(graph, source)
    @graph = graph
    @source = source

    @marked = Array.new(graph.v) { false }
    @edge_to = Array.new(graph.v) 
    @distance = Array.new(graph.v)

    bfs
  end

  def has_path_to?(v)
    @marked[v]
  end

  def path_to(v)
    return nil if !has_path_to(v)
    
    path = []
    x = v

    while x != @source
      path << x
      x = @edge_to[x]
    end

    path << @source

    path.reverse
  end

  def distance(v)
    path_to(v).length - 1
  end

  def bfs
    q = Queue.new
    @marked[@source] = true
    @edge_to[@source] = @source
    @distance[@source] = 0
    q.enqueue(@source)

    while q.size > 0
      v = q.dequeue
      @graph.adj(v).each do |a|
        next if @marked[a]

        @marked[a] = true
        @edge_to[a] = v
        @distance[a] = @distance[v] + 1
        q.enqueue(a)
      end
    end
  end
end