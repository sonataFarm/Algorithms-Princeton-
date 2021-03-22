require 'pry'
require './resizing_array_stack_of_strings.rb'

stack = ResizingArrayStackOfStrings.new

args = ARGV
args.each do |str|
  if str == '-'
    puts stack.pop
  else
    stack.push(str)
  end
end
