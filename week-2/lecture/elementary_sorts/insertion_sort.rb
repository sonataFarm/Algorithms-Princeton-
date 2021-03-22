require 'byebug'

# iterate through array from 0 to length - 1
# for each iteration i,
# compare i to its leftmost neighbor.
# if i < leftmost neighbor, swap them.
# continue swapping the element that started at i with its leftmost neighbor
# until i >= its leftmost neighbor

# O(n**2)
# n**2 / 4
# good for partially sorted collections

class Array
  def sort!
    self.each_with_index do |el, i|
      curr = i
      while self[curr] < self[curr - 1] && curr > 0 do
        self[curr], self[curr - 1] = self[curr - 1], self[curr]
        curr -= 1
      end
    end
  end
end
