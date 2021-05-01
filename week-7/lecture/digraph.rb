class Digraph
  attr_reader :v, :e
  def initialize(v)
    @v = v
    @e = 0

    @adj = Array.new(@v) { Array.new }
  end

  def add_edge(from, to)
    @adj[from] << to
    @e += 1
  end

  def adj(v)
    @adj[v]
  end

  def reverse
    reversed = Digraph.new(@v)

    @adj.each_with_index do |adj, prev_from|
      adj.each { |prev_to| reversed.add_edge(prev_to, prev_from ) }
    end

    reversed
  end
end