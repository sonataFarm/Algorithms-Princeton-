require 'pry'
require 'byebug'

class MergeSort
  def self.Sort(arr)
    aux = Array.new(arr.length)
    sort(arr, aux, 0, arr.length - 1)
    arr
  end

  def self.sort(arr, aux, lo, hi)
    puts "hi - lo is #{hi - lo}" if hi - lo > 1
    # lo and hi are inclusive
    return if lo >= hi
    mid = lo + ((hi - lo) / 2)
    sort(arr, aux, lo, mid)
    sort(arr, aux, mid + 1, hi)

    # copy numbers in range over to aux
    lo.upto(hi) { |idx| aux[idx] = arr[idx] }

    # perform the merge
    i = lo # beginning of right half
    j = mid + 1 # beginning of left half
    k = lo # beginning of current span

    while k <= hi do
      if i > mid
        arr[k] = aux[j]
        j += 1
      elsif j > hi
        arr[k] = aux[i]
        i += 1
      elsif aux[i] <= aux[j]
        arr[k] = aux[i]
        i += 1
      else
        arr[k] = aux[j]
        j += 1
      end
      k += 1
    end
  end
end

numbers = Array.new(10000000) { |i| i }.shuffle!
MergeSort::Sort(numbers)
