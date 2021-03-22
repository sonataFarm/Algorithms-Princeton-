require 'pry'
require 'byebug'

class Stack
  attr_accessor :first # DEV
  def initialize
    @first = nil
  end

  def push(value)
    node = Node.new(value)
    node.next = @first
    @first = node
  end

  def pop
    return if @first == nil
    else
      popped = @first
      @first = popped.next
      popped.value
    end
  end

  def is_empty
    @first.nil?
  end
end

class Node
  attr_accessor :next
  attr_reader :value
  def initialize(value)
    @value = value
    @next = nil
  end
end

# main
stack_of_strings = Stack.new

args = ARGV
args.each do |str|
  if str == '-'
    puts stack_of_strings.pop
  else
    stack_of_strings.push(str)
  end
end
