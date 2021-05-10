require 'set'

class EdgeWeightedDigraph
  class Edge
    attr_reader :from, :to, :weight
    def initialize(from, to, weight)
      @from = from
      @to = to
      @weight = weight
    end
  end

  attr_reader :v, :e
  def initialize(v)
    @v = v
    @e = 0
    @adj = Array.new(v) { Set.new }
  end

  def add_edge(from, to, weight)
    @adj[from] << Edge.new(from, to, weight)
    @e += 1
  end

  def adj(v)
    @adj[v].to_a
  end
end