require './bag'

class Graph
  def initialize(v)
    @v = v
    @e = 0
    @adj = Array.new(@v) { Bag.new }
  end

  def add_edge(v, w)
    @adj[v].add(w)
    @adj[w].add(v)
    @e += 1
  end

  def adj(v)
    @adj[v]
  end

  def degree(v)
    @adj[v].size
  end

  def max_degree
    @adj.max_by { |v| v.size }.size
  end

  def avg_degree
    2.0 * @e / @v
  end
end