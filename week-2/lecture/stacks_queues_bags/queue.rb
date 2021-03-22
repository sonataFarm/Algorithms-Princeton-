require 'pry'
require './linked_queue_of_strings.rb'

queue = LinkedQueueOfStrings.new

args = ARGV
args.each do |str|
  if str == '-'
    puts queue.dequeue
  else
    queue.enqueue(str)
  end
end

binding.pry
