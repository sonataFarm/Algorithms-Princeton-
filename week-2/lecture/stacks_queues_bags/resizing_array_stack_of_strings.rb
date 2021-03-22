require 'byebug'

class ResizingArrayStackOfStrings
  def initialize
    @items = Array.new(1)
    @top = 0
  end

  def push(value)
    # add item to array
    # if it's the last item, double the size!
    @items[@top] = value
    @top += 1

    if @top == @items.length
      double!
    end

    value
  end

  def pop
    return if @top == 0
    @top -= 1
    to_pop = @items[@top]
    @items[@top] = nil

    if @top < @items.length / 4
      quarter!
    end

    to_pop
  end

  def empty?
    @top == 0
  end

  def double!
    doubled = Array.new(@items.length * 2)
    @items.each_with_index { |item, idx| doubled[idx] = item }
    @items = doubled
  end

  def quarter!
    quartered = Array.new(@items.length / 4)
    for i in 0...@top
      quartered[i] = @items[i]
    end

    @items = quartered
  end
end
