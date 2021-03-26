require 'pry'

class Array
  def quick_select(k)
    arr = Array.new(self)
    arr.shuffle!

    lo = 0
    hi = arr.length - 1
    p = nil
    while p != k do
      puts "lo is #{lo}, hi is #{hi}"

      p = partition(arr, lo, hi)

      return arr[p] if p == k

      if k < p
        hi = p - 1
      else
        lo = p + 1
      end
    end
  end

  def partition(arr, lo, hi)
    i = lo + 1
    j = hi

    while true do
      while arr[i] < arr[lo] do
        i += 1
        break if i == hi
      end

      while arr[j] > arr[lo] do
        j -= 1
        break if j == lo
      end

      break if i >= j

      arr[i], arr[j] = arr[j], arr[i]
    end

    arr[lo], arr[j] = arr[j], arr[lo]

    j
  end
end

binding.pry
