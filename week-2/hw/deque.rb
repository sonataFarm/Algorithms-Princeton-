require 'pry'

class Node
  attr_accessor :next, :prev
  attr_reader :value
  def initialize(value)
    @value = value
    @next = nil
    @prev = nil
  end
end

class Deque
  def initialize
    @first = nil
    @last = nil
    @size = 0
  end

  def empty?
    size == 0
  end

  def size
    @size
  end

  def add_first(item)
    n = Node.new(item)

    if empty?
      @first = n
      @last = n
    else
      n.next = @first
      @first.prev = n
      @first = n
    end

    @size += 1

    nil
  end

  def add_last(item)
    n = Node.new(item)

    if empty?
      @first = n
      @last = n
    else
      @last.next = n
      n.prev = @last
      @last = n
    end

    @size += 1

    nil
  end

  def remove_first
    if empty?
      nil
    else
      old_first = @first
      @first = old_first.next

      @size -= 1
      reset_first_and_last if empty?

      old_first.value
    end
  end

  def remove_last
    if empty?
      nil
    else
      old_last = @last

      @last = old_last.prev
      @last && @last.next = nil

      @size -= 1
      reset_first_and_last if empty?

      old_last.value
    end
  end

  def each
    curr = @first
    while curr
      yield(curr.value)
      curr = curr.next
    end
  end

  private
  def reset_first_and_last
    @first = @last = nil
  end
end
