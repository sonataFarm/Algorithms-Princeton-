class CC
  def initialize(graph)
    @marked = Array.new(graph.v) { false }
    @component_id = Array.new(graph.v)
    @count = 0
    @graph = graph
    process_graph
  end

  def count 
    @count
  end
  
  def id(v)
    @component_id[v]
  end
  
  private 
  def process_graph
    0.upto(@graph.v - 1) do |v|
      if !@marked[v]
        dfs(v)
        @count += 1
      end
    end
  end

  def dfs(v)
    @marked[v] = true
    @component_id[v] = @count
    @graph.adj(v).each { |a| dfs(a) unless @marked[a] }
  end
end