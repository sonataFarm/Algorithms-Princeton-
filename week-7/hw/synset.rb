class Synset
  attr_reader :id, :nouns, :hypernyms
  def initialize(id)
    @id = id
    @nouns = []
    @hypernyms = []
  end
end