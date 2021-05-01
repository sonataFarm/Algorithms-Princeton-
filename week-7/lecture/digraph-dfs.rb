class DigraphDFS
  def initialize(graph, source)
    # s is source vertex
    @source = source
    @graph = graph
    @marked = Array.new(graph.v) { false }
    @edge_to = Array.new(graph.v)

    dfs
  end
  
  def has_path_to?(v)
    @marked[v]
  end

  def path_to(v)
    path = []
    x = v

    while x != @source
      path << x
      x = @edge_to[x]
    end

    path << @source

    path.reverse
  end

  def dfs(source = nil)
    if !source
      source = @source
      @edge_to[source] = source
    end

    @marked[source] = true

    @graph.adj(source).each do |a|
      if !@marked[a]
        @edge_to[a] = source
        dfs(a)
      end
    end
  end
end