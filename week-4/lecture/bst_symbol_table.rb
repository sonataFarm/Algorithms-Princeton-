require 'faker'
require 'pry'

class BST
  class Node
    attr_accessor :key, :val, :left, :right
  
    def initialize(key, val)
      @key = key
      @val = val
      @left = nil
      @right = nil
    end

    def inspect
      "[#{@key}: #{val}]"
    end
  end

  def initialize
    @root = nil
  end

  def put(key, val)
    @i = 0
    @root = put_recursive(@root, key, val)
    puts "recursive calls: #{@i}"
  end

  def put_recursive(node, key, val)
    @i += 1
    return BST::Node.new(key, val) if node.nil?
    
    if node.key == key
      node.val = val
    elsif key < node.key
      node.left = put_recursive(node.left, key, val)
    else
      node.right = put_recursive(node.right, key, val)
    end
    
    node
  end

  def get(key)
    get_recursive(@root, key)
  end

  def get_recursive(node, key)
    return nil if node.nil?
    return node.val if key == node.key

    next_node = key < node.key ? node.left : node.right
    get_recursive(next_node, key)
  end

  def delete(key, val)
    # TODO
  end

  def iterator
    @iterator = []
    
    iterator_recursive(@root)

    @iterator
  end

  def iterator_recursive(node)
    return if node.nil?

    iterator_recursive(node.left)   
    @iterator << node.key
    iterator_recursive(node.right)
  end
end

bst = BST.new

LENGTH = 250000
1.upto(LENGTH) do |i|
  bst.put(rand(0..LENGTH), Faker::Name.name)
  puts i
end

binding.pry