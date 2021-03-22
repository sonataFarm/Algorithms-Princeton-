require 'pry'
# insertion sort with stride length h
class Array
  def sort!
    shellsort_sequence.each do |h|
      puts "h is #{h}"
      0.upto(self.length - 1) do |i|
        curr = i
        while curr > 0 && self[curr] < self[curr - h]
          self[curr - h], self[curr] = self[curr], self[curr - h]
          curr = curr - h
        end
      end
    end
  end

  def shellsort_sequence
    # use 3x + 1
    sequence = [1]

    i = 4
    while i < self.length / 3
      sequence << i
      i = 3 * i + 1
    end
    sequence.reverse
  end
end
