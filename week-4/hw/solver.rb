require './priority_queue.rb'
require './search_node.rb'
require './board.rb'

class Solver
  def initialize(initial_board)
    @initial_board = initial_board
    @solution = nil
    solve!
  end

  def solvable?
    !!@solution
  end

  def moves
    solvable? ? @solution.moves : -1
  end

  def solution
    return nil if !solvable?

    boards = []
    node = @solution
    while !node.nil?
      boards << node.board
      node = node.prev_node
    end
    
    boards.reverse
  end

  def solve!
    @pq = MinPQ.new
    @pq_twin = MinPQ.new

    @pq.insert(SearchNode.new(
      board: @initial_board,
      moves: 0,
      prev_node: nil
    ))

    @pq_twin.insert(SearchNode.new(
      board: @initial_board.twin,
      moves: 0,
      prev_node: nil
    ))

    while true
      best_node = @pq.del_min

      if best_node.board == @initial_board.goal
        @solution = best_node
        break
      end

      best_node_twin = @pq_twin.del_min
      if best_node_twin.board == @initial_board.goal
        @solution = nil
        break
      end

      next_nodes = generate_next_nodes(best_node)
      next_nodes.each { |n| @pq.insert(n) }
      
      next_nodes_twin = generate_next_nodes(best_node_twin)
      next_nodes_twin.each { |n| @pq_twin.insert(n) }
    end
  end

  def generate_next_nodes(node)
    node.board.neighbors.reject { |n| node.prev_node && n == node.prev_node.board }.map do |b|
      SearchNode.new(board: b, moves: node.moves + 1, prev_node: node)
    end
  end
end