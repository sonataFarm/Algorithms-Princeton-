class EdgeWeightedGraph
  class Edge
    attr_reader :weight
    def initialize(v, w, weight)
      @v = v
      @w = w
      @weight = weight
    end

    def either
      @v
    end

    def other(v)
      v == @v ? @w : @v
    end
  end

  def initialize(v)
    @v = v
    @e = 0

    @adj = Array.new(v) { Set.new }
  end

  def add_edge(e)
    v = e.either, w = e.other(v)

    adj[v].add(e)
    adj[w].add(e)
  end

  def adj(v)
    adj[v]
  end
end