class IndexedMinPQ
  def initialize(n)
    @keys = Array.new(n)
    @pq = Array.new(n + 1)
    @qp = Array.new(n)
    @top = 0
  end

  def contains?(i)
    @keys[i]
  end

  def insert(i, key)
    return false if @keys[i]
    @top += 1
    
    @keys[i] = key
    @pq[@top] = i
    @qp[i] = @top

    swim(@top)
  end 

  def any?
    @top > 0
  end

  def del_min
    swap(1, @top)

    min = @pq[@top]
    @keys[min] = nil
    @qp[min] = nil
    @pq[@top] = nil
    @top -= 1
    
    sink(1)
    min
  end

  def change_key(i, key)
    @keys[i] = key
    sink(@qp[i])
    swim(@qp[i])
  end

  private 
  def swap(j, k)
    @pq[j], @pq[k] = @pq[k], @pq[j]
    a, b = @pq[j], @pq[k]
    @qp[a], @qp[b] = @qp[b], @qp[a]
  end

  def sink(k)
    while 2 * k <= @top do
      j = 2 * k
      j += 1 if @pq[j + 1] && greater(j, j +1)

      if greater(k, j)
        swap(j, k)
        k = j
      else
        break
      end
    end
  end

    def swim(k)
      while k > 1 && greater(k / 2, k)
        swap(k / 2, k)
        k = k / 2
      end
    end

  def greater(j, k)
    @keys[@pq[j]] > @keys[@pq[k]]
  end
end