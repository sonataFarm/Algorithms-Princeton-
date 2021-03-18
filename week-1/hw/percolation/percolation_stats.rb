require 'pry'
require './percolation'
require 'benchmark'

class PercolationStats
  def initialize(n, trials)
    @n = n.to_i
    @trials = trials.to_i

    if @n <= 0 || @trials <= 0
      raise ArgumentError.new "n and trials must be integers > 0"
    end

    @results = []
  end

  def mean
    @mean || @mean = @results.reduce(0, :+) / @trials
  end

  def stddev
    Math.sqrt(@results.map { |res| (res - mean)**2 }.reduce(0, :+) / (@trials - 1))
  end

  def confidence_lo
    mean - ((1.96 * stddev) / Math.sqrt(@trials))
  end

  def confidence_hi
    mean + ((1.96 * stddev) / Math.sqrt(@trials))
  end

  def run
    @results = @results.clear
    @trials.times do
      run_trial
    end
  end

  private

  def run_trial
    p = Percolation.new(@n)

    while !p.percolates?
      p.open(rand(0...@n), rand(0...@n))
    end

    @results << p.number_of_open_sites.to_f / @n**2
  end
end

def main
  n = ARGV[0]
  t = ARGV[1]

  stats = PercolationStats.new(n, t)
  time = Benchmark.bm { |x| x.report { stats.run } }

  puts "mean                    = #{stats.mean}"
  puts "stddev                  = #{stats.stddev}"
  puts "95% confidence interval = [#{stats.confidence_lo}, #{stats.confidence_hi}]"
end

main
