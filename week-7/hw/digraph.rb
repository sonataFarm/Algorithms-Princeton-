require 'set'

class Digraph
  attr_reader :v, :e, :adj
  def initialize(v)
    @v = v
    @e = 0

    @adj = Array.new(v) { Set.new }
  end

  def add_edge(from, to)
    @adj[from].add(to)
  end
  
  def adj(v)
    @adj[v]
  end
end