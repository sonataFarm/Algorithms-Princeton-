require '../../week-2/lecture/stacks_queues_bags/array_stack.rb'
require './digraph'

# reverse post order.
class TopologicalSort
  def initialize(graph)
    @marked = Array.new(graph.v) { false }
    @graph = graph
    sort
  end

  def sort
    0.upto(@graph.v - 1) do |v|
      dfs(v) if !@marked[v]
    end
  end

  def dfs(v)
    @marked[v] = true
    @graph.adj(v).each do |a|
      dfs(a) if !@marked[a]
    end

    @reverse_post_order ||= Stack.new(7)
    @reverse_post_order.push(v)
  end

  def order
    return @order if @order

    @order = []
    until @reverse_post_order.empty?
      order << @reverse_post_order.pop
    end

    @order
  end
end