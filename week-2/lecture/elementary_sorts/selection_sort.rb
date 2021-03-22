require 'benchmark'
require './array'
# implement selection sort
# iterate from 0 to length - 1
# on each iteration i,
# select the smallest value from i to end
# swap i, min

class Array
  def sort!
    self.each_with_index do |el, i|
      min = i
      i.upto(self.length - 1) do |j|
        if self[j] < self[min]
          min = j
        end
      end

      self[i], self[min] = self[min], self[i]
    end
  end
end
