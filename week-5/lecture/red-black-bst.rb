class Node
  attr_accessor :key, :right, :left, :color
  def self.red?(node)
    return false if node.nil?
    node.color == :RED
  end

  def initialize(key, color = :RED)
    @key = key
    @color = color
    @left = nil
    @right = nil
  end

  def rotate_left!
    new_parent = self.right
    self.right = new_parent.left
    new_parent.left = self

    new_parent.color = self.color
    self.color = :RED

    new_parent
  end

  def rotate_right!
    new_parent = self.left
    self.left = new_parent.right
    new_parent.right = self

    new_parent.color = self.color
    self.color = :RED
    
    new_parent
  end

  def swap_colors!
    self.color = :RED
    self.left.color = :BLACK
    self.right.color = :BLACK
  end
end

class RedBlackBST
  def initialize
    @root = nil
  end

  def insert(key)
    @root = insert_recursive(key, @root)
  end

  def search(key)
    search_recursive(key, @root)
  end

  
  private
  def search_recursive(key, node)
    return false if node.nil?
    return true if node.key == key

    node_to_search = key < node.key ? node.left : node.right
    search_recursive(key, node_to_search)
  end
  
  def insert_recursive(key, node)
    return Node.new(key) if node.nil?
    return node if key == node.key

    if key < node.key
      node.left = insert_recursive(key, node.left)
    else 
      node.right = insert_recursive(key, node.right)
    end

    node = node.rotate_left! if Node.red?(node.right) && !Node.red?(node.left)
    node = node.rotate_right! if node.left && Node.red?(node.left) && Node.red?(node.left.left)
    node.swap_colors! if Node.red?(node.left) && Node.red?(node.right)

    node
  end
end