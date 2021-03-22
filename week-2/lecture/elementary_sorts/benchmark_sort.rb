SORT_SRC = './selection_sort'

require 'pry'
require 'benchmark'
require './array'
require SORT_SRC

puts "Sort source: #{SORT_SRC}"
puts "\n"

a = Array.new(ARGV[0].to_i) { rand(10**10) }
puts "Sorted before: #{a.sorted?}"
puts "\n"
puts "*" * 10

Benchmark.bm { |x| x.report { a.sort! } }

puts "*" * 10
puts "\n"
puts "Sorted after: #{a.sorted?}"
puts "\n"
