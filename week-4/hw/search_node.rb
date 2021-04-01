class SearchNode
  attr_reader :board, :moves, :prev_node

  def initialize(options)
    @board = options[:board]
    @moves = options[:moves]
    @prev_node = options[:prev_node]
  end

  def priority
    @board.manhattan + @moves
  end

  def <(that)
    self.priority < that.priority
  end

  def >(that)
    self.priority > that.priority
  end
end