require 'pry'
require 'byebug'
class MaxPQ
  # implements a max priority queue using a binary heap
  attr_reader :heap
  def initialize(n)
    @heap = Array.new(n + 1)
    @n = 0
  end

  def insert(key)
    if full?
      raise StandardError.new "Cannot insert: Queue is full"
    end

    @n += 1
    @heap[@n] = key
    swim(@n)
  end

  def del_max
    raise StandardError.new "Cannot delete max: Queue is empty" if empty?

    max = @heap[1]
    @heap[1] = @heap[@n]
    @heap[@n] = nil
    @n -= 1

    sink(1) unless empty?

    max
  end

  def get_max 
    raise StandardError.new "Cannot get max: Queue is empty" if empty?
    @heap[@n]
  end

  def size
    @n
  end

  def full?
    @n == @heap.length - 1
  end

  def empty?
    @n == 0
  end

  def swim(i)
    while i > 1
      parent_idx = i / 2
      # compare with its parent
      if @heap[parent_idx] > @heap[i]
        break
      else
        swap(parent_idx, i)
        i = parent_idx
      end
    end
  end

  def sink(i)
    while !in_place?(i) do
      if !@heap[i * 2 + 1]
        larger_child = i * 2
      else
        larger_child = @heap[i * 2] > @heap[i * 2 + 1] ? i * 2 : i * 2 + 1
      end
        
      swap(i, larger_child)
      i = larger_child
    end
  end

  def in_place?(i)
    binding.pry if @heap[i].nil?
    return false if @heap[i / 2] && @heap[i] > heap[i / 2]
    return false if @heap[i * 2] && @heap[i] < @heap[i * 2]
    return false if @heap[i * 2 + 1] && @heap[i] < @heap[i * 2 + 1] 

    true
  end

  def swap(i, j)
    @heap[i], @heap[j] = @heap[j], @heap[i]
  end
end
