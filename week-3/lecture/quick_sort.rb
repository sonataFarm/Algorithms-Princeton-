class QuickSort
  def self.sort(arr)
    arr.shuffle!
    sort_recursive(arr, 0, arr.length - 1)
  end
  def self.sort_recursive(arr, lo, hi)
    return if lo >= hi
    partition = partition(arr, lo, hi)

    binding.pry if partition == nil

    sort_recursive(arr, lo, partition - 1)
    sort_recursive(arr, partition + 1, hi)
  end

  def self.partition(arr, lo, hi)
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
