require 'pry'

class BST_Symbol_Table
  class Node
    attr_reader :key
    attr_accessor :val, :left, :right
    def initialize(key, val)
      @key = key
      @val = val
      @left = @right = nil
    end

    def inspect
      "key: #{@key}, val: #{@val} left: #{@left ? @left.key : nil} right: #{@right ? @right.key : nil}"
    end
  end

  def initialize
    @root = nil
  end

  def insert(key, val)
    @root = insert_recursive(key, val, @root)
  end

  def insert_recursive(key, val, node)
    return Node.new(key, val) if node.nil?
    
    if node.key == key
      node.val = val
    elsif key < node.key
      node.left = insert_recursive(key, val, node.left)
    else
      node.right = insert_recursive(key, val, node.right)
    end

    node
  end

  def iterator
    @iterator = []
    traverse_in_order(@root) { |node| @iterator << node.key }
    @iterator
  end

  def traverse_in_order(root, &block)
    return if root.nil?
    binding.pry
    traverse_in_order(root.left, &block)
    yield(root)
    traverse_in_order(root.right, &block)
  end
end