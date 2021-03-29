class MinPQ
  def initialize(n)
    @heap = Array.new(n)
    @n = 0
  end

  def insert(val)
    raise StandError.new "Cannot insert: Heap is full" if full?

    @n += 1
    @heap[@n] = val
    swim(@n)
  end

  def del_min
    raise StandardError.new "Cannot delete min: Heap is empty" if empty?

    min = @heap[1]
    swap(@n, 1)
    @heap[@n] = nil
    @n -= 1

    sink(1)

    min
  end

  def min
    @heap[1]
  end

  def empty?
    @n == 0
  end

  def full?
    @n == @heap.length - 1
  end

  private

  def sink(i)
    while !in_place?(i) do
      # there are either one or two children, or it would be in-place.
      if !@heap[i * 2 + 1]
        min_child = i * 2
      else
        min_child = @heap[i * 2] < @heap[i * 2 + 1] ? i * 2 : i * 2 + 1
      end

      swap(i, min_child)
      i = min_child
    end
  end

  def swim(i)
    while !in_place(i) do
      parent = i / 2
      swap(i, parent)
      i = parent
    end
  end

  def swap(i, j)
    @heap[i], @heap[j] = @heap[j], @heap[i]
  end

  def in_place?(i)
    return false if @heap[i / 2] && @heap[i] < @heap[i / 2]
    return false if @heap[i * 2] && @heap[i] > @heap[i * 2]
    return false if @heap[i * 2 + 1] && heap[i] > @heap[i * 2 + 1]

    true
  end
end