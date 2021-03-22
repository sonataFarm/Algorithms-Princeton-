class Array
  def shuffle!
    0.upto(self.length) do |i|
      swap_idx = rand(0..i)
      self[swap_idx], self[i] = self[i], self[swap_idx]
    end
  end
end
