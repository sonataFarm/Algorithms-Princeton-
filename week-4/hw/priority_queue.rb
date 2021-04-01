class MinPQ
  def initialize
    @queue = Array.new(2)
    @n = 0
  end

  def insert(item)
    @n += 1
    @queue[@n] = item
    swim(@n)
    resize! if full?
    item
  end

  def del_min
    min = @queue[1]
    swap(1, @n)
    @queue[@n] = nil
    @n -= 1
    sink(1)

    min
  end

  def size
    @n
  end

  def sink(i)
    while !in_place?(i) do
      left_child = 2 * i
      right_child = 2 * i + 1
      
      if !@queue[right_child]
        swap(i, left_child)
        i = left_child
      else
        child_to_swap = (@queue[left_child] < @queue[right_child] ? left_child : right_child)
        swap(i, child_to_swap)
        i = child_to_swap
      end
    end
  end

  def swim(i)
    while !in_place?(i) do
      swap(i, i / 2)
      i = i / 2
    end
  end

  def resize!
    old_queue = @queue
    @queue = Array.new(old_queue.length * 2)
    old_queue.each_with_index { |val, idx| @queue[idx] = val }
  end

  def full?
    @n == @queue.length - 1
  end

  def swap(a, b)
    @queue[a], @queue[b] = @queue[b], @queue[a]
  end

  def in_place?(i)
    return false if @queue[i / 2] && @queue[i] < @queue[i / 2]
    return false if @queue[i * 2] && @queue[i] > @queue[i * 2]
    return false if @queue[i * 2 + 1] && @queue[i] > @queue[i * 2 + 1]
    
    true
  end
end