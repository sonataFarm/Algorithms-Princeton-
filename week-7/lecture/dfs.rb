require './graph-api.rb'

class Paths
  def initialize(g, s) # find paths in graph G from source vertex s
    @g = g
    @s = s

    dfs
  end

  def has_path_to?(v)
    @marked[v]
  end

  def path_to(v)
    # null if no such path
    return nil if !@marked[v]

    path = []

    x = v

    while x != @s do
      path << x
      x = @edge_to[x]
    end

    path << @s

    path.reverse
  end

  private 

  def dfs(v = nil, edge_to = nil)
    puts "v is #{v}, edge_to is #{edge_to}"
    if (!v)
      @marked = Array.new(G.v) { false }
      @edge_to = Array.new(G.v)
      dfs(@s)
    else
      @edge_to[v] = edge_to
      @marked[v] = true

      @g.adj(v).items.each { |a| dfs(a, v) if !@marked[a] }
    end
  end
end