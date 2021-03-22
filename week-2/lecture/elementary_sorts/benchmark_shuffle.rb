SHUFFLE_SRC = './knuth_shuffle'

require 'pry'
require 'benchmark'
require './array'
require SHUFFLE_SRC

puts "Source: #{SHUFFLE_SRC}"
puts "\n"

a = Array.new(ARGV[0].to_i) { rand(10**10) }
a.sort!

puts "Sorted before: #{a.sorted?}"
puts "\n"
puts "*" * 10

Benchmark.bm { |x| x.report { a.shuffle! } }

puts "*" * 10
puts "\n"
puts "Sorted after: #{a.sorted?}"
puts "\n"
