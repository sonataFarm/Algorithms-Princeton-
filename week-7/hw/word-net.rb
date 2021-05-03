require 'pry'
require 'csv'
require '../../lib/queue'
require './digraph'
require './synset'
require './sap'

class WordNet
  def initialize(synsets_path, hypernyms_path)
    process_synsets(synsets_path)
    process_hypernyms(hypernyms_path)
    build_graph
  end

  def nouns
    @nouns.keys()
  end

  def is_noun?(word)
    !!(@nouns[word].length > 0)
  end

  def distance(noun_a, noun_b)
    sap = SAP.new(@graph)
    sap.length(@nouns[noun_a], @nouns[noun_b])
  end

  def sap(noun_a, noun_b)
    sap = SAP.new(@graph)
    sap.path(@nouns[noun_a], @nouns[noun_b])
  end

  def print_friendly_path(noun_a, noun_b)
    sap = sap(noun_a, noun_b)

    if sap.length == 1
      puts @synsets[sap[0]].nouns.join(', ')
    else
      paths = sap(noun_a, noun_b).map do |p| 
        p.map { |p| @synsets[p].nouns.join(', ') }
      end
      paths[0].reverse.join(' => ') + ' => ' + paths[1].join(' <= ')
    end
  end

  private

  def process_synsets(path)
    csv = CSV.read(path, quote_char: "|")
    
    @nouns = Hash.new
    @synsets = {}
    
    csv.each do |row|
      id = row[0].to_i
      nouns = row[1].split(' ')
      s = @synsets[id] = Synset.new(id)

      nouns.each do |n|
        s.nouns << n
        @nouns[n] = [] if !@nouns[n]
        @nouns[n] << id
      end
    end
  end

  def process_hypernyms(path)
    csv = CSV.read(path)
    
    csv.each do |row|
      s = @synsets[row[0].to_i]
      row[1..-1].each { |h| s.hypernyms << h.to_i }
    end
  end

  def build_graph
    @graph = Digraph.new(@synsets.length)
    @synsets.each do |_, s|
      s.hypernyms.each do |h|
        @graph.add_edge(s.id, h)
      end
    end
  end
end