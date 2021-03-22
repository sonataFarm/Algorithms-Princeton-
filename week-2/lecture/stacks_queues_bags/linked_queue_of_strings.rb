require 'pry'

class Node
  attr_accessor :prev
  attr_reader :value

  def initialize(value)
    @value = value
    @prev = nil
  end
end

class LinkedQueueOfStrings
  def initialize
    @front = nil
    @back = nil
  end

  def enqueue(value)
    new_node = Node.new(value)
    if @front.nil?
      @front = new_node
      @back = new_node
    else
      @back.prev = new_node
      @back = new_node
    end
  end

  def dequeue
    return if @front.nil?

    value_to_dequeue = @front.value

    if @front == @back
      @front = @back = nil
    else
      @front = @front.prev
    end
    value_to_dequeue
  end

  def each
    current = @front
    while (current)
      yield (current)
      current = current.prev
    end
  end
end
