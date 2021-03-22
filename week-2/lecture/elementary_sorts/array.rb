class Array
  def sorted?
    self.each_cons(2).all? { |a, b| a <= b }
  end
end
