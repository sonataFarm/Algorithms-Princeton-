require 'pry'
require 'byebug'

class Site
  attr_accessor :open, :node_count, :parent

  def initialize(row, col, open = false)
    @open = open
    @grid_pos = { row: row, col: col }
    @parent = self
    @node_count = 1 # number of nodes below this node, inclusive
  end

  def open?
    @open
  end

  def root
    root = @parent
    while root.parent != root
      root = root.parent
    end
    root
  end
end

class SuperNode < Site
  attr_accessor :node_count, :parent
  attr_writer :root
  def initialize(pos)
    @open = true
    @pos = pos
    @parent = self
    @node_count = 1 # number of nodes below this node, inclusive
  end
end

class Percolation
  attr_accessor :sites
  attr_reader :top_supernode, :bottom_supernode

  # create n-by-n grid, with all sites initially blocked
  def initialize(n)
    @sites = Array.new(n) { Array.new(n) }

    @sites.each_with_index do |row, row_idx|
      row.each_with_index do | _, col_idx |
        row[col_idx] = Site.new(row_idx, col_idx)
      end
    end

    @top_supernode = SuperNode.new(:TOP)
    @bottom_supernode = SuperNode.new(:BOTTOM)
    @supernodes = [@top_supernode, @bottom_supernode]

    @sites[0].each { |site| union(site, @top_supernode) }
    @sites[-1].each { |site| union(site, @bottom_supernode) }
  end

  def open(row, col)
    if @sites[row] == nil || @sites[row][col] == nil
      return
    end

    site = @sites[row][col]
    site.open = true
    neighbors(row, col).each do |neighbor|
      if neighbor.open?
        union(site, neighbor)
      end
    end
    # opens site at row, col if not already open
    # connects site at row, col to each of its open neighbors.
  end

  def open?(row, col)
    @sites[row][col].open?
  end

  def full?(row, col)
    connected?(@sites[row][col], @top_node)
  end

  def number_of_open_sites
    @sites.flatten.select { |site| site.open? }.count
  end

  def percolates?
    connected?(@top_supernode, @bottom_supernode)
  end

  private

  def neighbors(row, col)
    neighbors = []

    neighbor_offsets = [ [-1, 0], [0, -1], [0, 1], [1, 0] ]

    neighbor_offsets.each do |row_offset, col_offset|
      row_idx = row + row_offset
      col_idx = col + col_offset

      next if row_idx < 0 || col_idx < 0

      if (@sites[row_idx] && @sites[row_idx][col_idx])
        neighbors << @sites[row_idx][col_idx]
      end
    end

    neighbors
  end

  def union(a, b)
    weighted_quick_union_union(a, b)
  end

  def connected?(a, b)
    weighted_quick_union_connected?(a, b)
  end

  # methods for QuickFindUF
  def quickfind_union(a, b)
    root_a = a.root
    root_b = b.root
    @sites.each do |row|
      row.each do |site|
        site.root = root_b if site.root == root_a
      end
    end
    @supernodes.each do |node|
      node.root = root_b if node.root == root_a
    end
  end

  def quickfind_connected?(a, b)
    a.root == b.root
  end

  # methods for WeightedQuickUnionUF
  def weighted_quick_union_union(a, b)
    root_a = a.root
    root_b = b.root

    smaller, bigger = [root_a, root_b].sort_by(&:node_count)

    smaller.parent = bigger
    bigger.node_count += smaller.node_count
  end

  def weighted_quick_union_connected?(a, b)
    a.root == b.root
  end
end
