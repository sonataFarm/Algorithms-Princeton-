class SeparateChainingST
  class Node
    attr_accessor :key, :val, :next
    def initialize(key, val)
      @key = key
      @val = val
    end

    def inspect
      "[#{key}: #{val}]"
    end
  end

  def initialize(n)
    @m = n / 5
    @st = Array.new(@m)
  end

  def hash(key)
    key.hash % @m
  end

  def insert(key, val)
    # if the st at key's hash is nil, insert there.
    i = hash(key)

    if @st[i].nil?
      @st[i] = Node.new(key, val)
      return
    else
      # if an entry already exists for key, update its value and return.
      curr = @st[i]

      while curr do
        return curr.val = val if curr.key == key
        curr = curr.next
      end

      # create a new node.
      node = Node.new(key, val)
      node.next = @st[i]
      @st[i] = node
    end
  end

  def search(key)
    i = hash(key)

    curr = @st[i]
    while curr do
      return curr.val if curr.key == key
      curr = curr.next
    end

    nil
  end

  def delete(key)
    i = hash(key)
    if @st[i] && @st[i].key == key
      @st[i] = @st[i].next
    else
      curr = @st[i]
      while curr && curr.next do
        if curr.next.key == key
          deleted = curr.next
          curr.next = curr.next.next
          return deleted
        end
        curr = curr.next
      end

      false
    end
  end
end