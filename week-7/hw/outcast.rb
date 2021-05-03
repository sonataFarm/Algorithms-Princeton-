require './word-net'

class Outcast
  def initialize(wordnet)
    @wordnet = wordnet
  end

  def outcast(nouns)
    distances = nouns.map { |n| compute_sum_of_distances(n, nouns) }
    nouns[distances.each_with_index.max[1]]
  end
  
  private
  
  def compute_sum_of_distances(from, nouns)
    nouns.map { |to| @wordnet.distance(from, to) }.reduce(&:+)
  end
end