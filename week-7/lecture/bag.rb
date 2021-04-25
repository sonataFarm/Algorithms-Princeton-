class Bag
  attr_accessor :items, :size
  def initialize
    @items = Array.new(1)
    @i = -1
    @size = 0
  end

  def add(item)
    @i += 1
    @items[@i] = item
    @size += 1

    resize_if_full!
  end

  def each(&block)
    @items[0..@i].each(&block)
  end

  def resize_if_full!
    return unless full?

    resized = Array.new(size * 2)
    @items.each_with_index { |item, idx| resized[idx] = item }
    @items = resized
  end

  def full?
    @size == @items.length 
  end
end