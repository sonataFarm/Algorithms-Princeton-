class Board
  def self.goal_board(n)
    tiles = Array.new(n) { |i| Array.new(n) { |j| (i * n) + j  + 1 } }
    tiles[-1][-1] = 0
    Board.new(tiles)
  end

  def self.random(n)
    ints = Array.new(n**2) { |i| i }.shuffle!
    tiles = Array.new(n) { Array.new(n) { ints.pop } }

    Board.new(tiles)
  end

  attr_reader :tiles

  def initialize(tiles)
    @tiles = tiles
  end

  def to_s
    max_tile_length = (dimension**2 - 1).to_s.length

    @tiles.reduce('') do |board_s, row|
      row_s = row.each_with_index.reduce('') do |row_s, (tile, idx)|
        row_s << tile.to_s
        row_s << ' ' * (max_tile_length - tile.to_s.length)
        row_s << ' ' unless idx == row.length - 1
        row_s
      end
      board_s + row_s + "\n"
    end
  end

  def dimension
    @dimension ||= @tiles[0].length
  end

  def hamming
    return @hamming if @hamming

    tiles = @tiles.flatten
    goal_tiles = goal.tiles.flatten
    @hamming = tiles.each_with_index.reduce(0) do |hamming, (tile, idx)|
      if tile == 0
        hamming
      else
        hamming + (goal_tiles[idx] == tile ? 0 : 1)
      end
    end
  end

  def manhattan
    return @manhattan if @manhattan

    manhattan = 0
    @tiles.each_with_index do |row, row_idx|
      row.each_with_index do |tile, col_idx|
        next if tile == 0

        goal_row = goal.tiles.index { |row| row.include?(tile) }
        manhattan += (row_idx - goal_row).abs

        goal_col = goal.tiles[goal_row].index(tile)
        manhattan += (col_idx - goal_col).abs
      end
    end

    @manhattan = manhattan
  end

  def goal
    @goal ||= Board.goal_board(dimension)
  end

  def is_goal?
    self == goal
  end

  def ==(that)
    self.tiles.flatten == that.tiles.flatten
  end

  def neighbors
    # get index of 0
    blank_row = @tiles.index { |row| row.include?(0) }
    blank_col = @tiles[blank_row].index(0)

    neighbors = []
    # iterate through offsets
    [[-1, 0], [0, 1], [1, 0], [0, -1]].each do |(row_offset, col_offset)|
      row = blank_row + row_offset
      col = blank_col + col_offset
      next if row < 0 || row > dimension - 1
      next if col < 0 || col > dimension - 1

      n_tiles = Marshal.load(Marshal.dump(@tiles))
      n_tiles[blank_row][blank_col], n_tiles[row][col] = n_tiles[row][col], n_tiles[blank_row][blank_col]

      neighbors << Board.new(n_tiles)
    end

    neighbors
  end

  def twin
    twin_tiles = Marshal.load(Marshal.dump(@tiles))
    row = twin_tiles.find { |row| !row.include?(0) }
    row[0], row[1] = row[1], row[0]
    Board.new(twin_tiles)
  end
end