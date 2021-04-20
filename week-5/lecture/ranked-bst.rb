require 'pry'

class Node
  attr_accessor :key, :left, :right, :count
  def initialize(key)
    @key = key
    @left = nil
    @right = nil
    @count = 1
  end
end

class BST
  def initialize
    @root = nil
  end

  def insert(key)
    @root = insert_recursive(key, @root)
  end

  def range_count(lo, hi)
    count = rank(hi) - rank(lo)
    count + (search(hi) ? 1 : 0)
  end

  def range_search(lo, hi)
    range_search_recursive(lo, hi, @root)
  end

  def search(key)
    search_recursive(key, @root)
  end

  def size
    @root.nil? ? 0 : @root.count
  end

  def rank(key)
    rank_recursive(key, @root)
  end

  private

  def range_search_recursive(lo, hi, node)
    return [] if node.nil?

    left, right, curr = [], [], []
    if node.key > lo
      left = range_search_recursive(lo, hi, node.left)
    end

    if node.key < hi
      right = range_search_recursive(lo, hi, node.right)
    end

    if node.key >= lo && node.key <= hi
      curr = [ node.key ]
    end

    left + curr + right
  end

  def rank_recursive(key, node)
    return 0 if node.nil?
    return (node.left ? node.left.count : 0) if node.key == key

    return rank_recursive(key, node.left) if key < node.key

    return (node.left ? node.left.count : 0) + 1 + rank_recursive(key, node.right)
  end

  def search_recursive(key, node)
    return false if node.nil?
    return true if key == node.key

    if key < node.key 
      return search_recursive(key, node.left)
    else
      return search_recursive(key, node.right)
    end
  end

  def insert_recursive(key, node)
    return Node.new(key) if node.nil?
    return node if key == node.key

    if key < node.key
      node.left = insert_recursive(key, node.left)
    else
      node.right = insert_recursive(key, node.right)
    end
    node.count = (node.left ? node.left.count : 0) + 1 + (node.right ? node.right.count : 0)

    node
  end
end