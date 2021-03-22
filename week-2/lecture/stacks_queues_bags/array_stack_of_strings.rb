require 'pry'
require 'byebug'

class Stack
  attr_accessor :first # DEV
  def initialize(n)
    @items = Array.new(n)
    @top = 0
  end

  def push(value)
    @items[@top] = value
    @top += 1
    value
  end

  def pop
    return if empty?
    @items[@top -= 1]
  end

  def empty?
    @top == 0
  end
end
