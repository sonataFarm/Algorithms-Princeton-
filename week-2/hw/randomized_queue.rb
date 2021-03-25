class Stack
  def initialize
    @items = Array.new(1)
    @top = -1
  end

  def empty?
    @top == -1
  end

  def size
    @top + 1
  end

  def push(item)
    @top += 1
    resize! if too_full?
    @items[@top] = item
  end

  # private
  def too_full?
     @top > @items.length - 1
  end

  def too_empty?
    @top < @items.length / 4
  end

  def resize!
    old_items = @items

    if too_full?
      @items = Array.new(old_items.length * 2)
    else
      @items = Array.new(old_items.length / 4)
    end

    old_items.compact.each_with_index { |item, idx| @items[idx] = item }
  end

  def [](idx)
    @items[idx]
  end

  def each_with_index
    @items.each_with_index { |item, idx| yield(item, idx) }
  end
end

class StackWithRandomAccess < Stack
  attr_reader :top
  def pop(idx)
    return if empty?
    raise ArgumentError if idx > @top

    item_to_pop = @items[idx]
    @items[idx], @items[@top] = @items[@top], nil
    @top -= 1

    resize! if too_empty?

    item_to_pop
  end
end

class Array
  def knuth_shuffle!
    self.each_with_index do |_, idx|
      swap_idx = rand(0..idx)
      self[swap_idx], self[idx] = self[idx], self[swap_idx]
    end
  end
end

class RandomizedQueue
  def initialize
    @items = StackWithRandomAccess.new
  end

  def empty?
    @items.empty?
  end

  def size
    @items.size
  end

  def enqueue(item)
    @items.push(item)
  end

  def dequeue
    @items.pop(random_idx)
  end

  def sample
    @items[random_idx]
  end

  def each
    all_items = Array.new(@items.top + 1)
    @items.each_with_index do |item, idx|
      item && all_items[idx] = item
    end

    all_items.knuth_shuffle!

    all_items.each do |item|
      yield(item)
    end

    nil
  end

  def random_idx
    rand(0..@items.top)
  end
end
