class AsciiTrie
  def initialize
    @root = Node.new
  end

  def insert(key, val)
    @root = insert_recursive(key, val, @root, 0)
  end

  def search(key)
    search_recursive(key, @root, 0)
  end

  def delete(key)
    @root = delete_recursive(key, @root, 0)
  end

  def all_words
    @words = [] 
    all_words_recursive(@root, '')
    @words
  end
  
  private

  def char_to_idx(c)
    c.ord
  end

  def all_words_recursive(node, str)
    return if node.nil?

    if node.val
      @words << str
    end

    node.next.each_with_index do |n, idx|
      all_words_recursive(n, str + idx.chr)
    end
  end

  def search_recursive(key, node, pos)
    if node.nil?
      false
    elsif pos == key.length
      node.val || false
    else
      next_char = key[pos]
      idx = char_to_idx(next_char)
      search_recursive(key, node.next[idx], pos + 1)
    end 
  end

  def insert_recursive(key, val, node, pos)
    node = Node.new if node.nil?

    if pos == key.length
      node.val = val
      return node
    end

    next_char = key[pos]
    idx = char_to_idx(next_char)
    node.next[idx] = insert_recursive(key, val, node.next[idx], pos + 1)

    node
  end

  def delete_recursive(key, node, pos)
    if pos == key.length
      node.val = nil
    else
      next_char = key[pos]
      idx = char_to_idx(next_char)
      node.next[idx] = delete_recursive(key, node.next[idx], pos + 1)

      if !node.next[idx].next.any?
        node.next[idx] = nil
      end
    end

    node
  end

  class Node
    attr_reader :next
    attr_accessor :val
    def initialize
      @val = nil
      @next = Array.new(256)
    end
  end
end





































# class Trie 
#   class Node
#     attr_accessor :next, :val
#     def initialize
#       @val = nil
#       @next = Array.new(26)
#     end

#     def [](char)
#       @next[char.downcase.ord - 'a'.ord]
#     end

#     def []=(char, val)
#       @next[char.downcase.ord - 'a'.ord] = val
#     end
#   end

#   def initialize
#     @root = Node.new
#   end

#   def put(key, val)
#     @root = put_recursive(key, val, @root, 0)
#   end

#   def search(key)
#     search_recursive(key, @root, 0) || nil
#   end

#   def delete(key)
    
#   end

#   private

  
#   def put_recursive(key, val, node, pos)
#     if pos == key.length
#       node.val = val
#     else
#       curr_char = key[pos]
#       node[curr_char] = Node.new unless node[curr_char]
#       node[curr_char] = put_recursive(key, val, node[curr_char], pos + 1)
#     end

#     node
#   end

#   def search_recursive(key, node, pos)
#     return false if node.nil?
#     return node.val if pos == key.length
#     curr_char = key[pos]
#     search_recursive(key, node[curr_char], pos + 1)
#   end
# end

