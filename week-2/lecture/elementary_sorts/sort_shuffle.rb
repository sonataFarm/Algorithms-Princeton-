class Array
  def shuffle!
    rands = Array.new(self.length) { rand() }
    self.sort_by!.with_index { |_, idx| rands[idx] }
  end
end
