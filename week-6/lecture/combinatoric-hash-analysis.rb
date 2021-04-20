class BinsAndBalls
  def initialize(n)
    @bins = Array.new(n) { 0 }
  end
  
  def toss(bin_number)
    @bins[bin_number] += 1
  end

  def all_bins_have_ball?
    @bins.all? { |bin| bin > 0 }
  end

  def any_bin_has_two_balls?
    @bins.any? { |bin| bin > 1 }
  end
end

class BirthdayProblem
  def initialize(rounds, bins)
    @bins = bins
    @rounds = rounds
    @results = []
    
    @rounds.times { run! }
  end

  def run!
    b = BinsAndBalls.new(@bins)

    tosses = 0
    while !b.any_bin_has_two_balls?
      b.toss(random_bin)
      tosses += 1
    end

    @results << tosses
  end

  def random_bin
    rand(0...@bins)
  end

  def expected
    Math.sqrt(Math::PI * @bins / 2)
  end

  def actual
    @results.reduce(&:+).to_f / @rounds.to_f
  end

  def difference
    (expected - actual).abs
  end

  def report
    puts "Expected: #{expected.truncate(2)}"
    puts "Actual: #{actual.truncate(2)}"
    puts "Difference: #{difference.truncate(2)}"
  end
end

class CouponCollector
  def initialize(rounds, bins)
    @bins = bins
    @rounds = rounds
    @results = []
    
    @rounds.times { run! }
  end

  def run!
    b = BinsAndBalls.new(@bins)

    tosses = 0
    while !b.all_bins_have_ball?
      b.toss(random_bin)
      tosses += 1
    end

    @results << tosses
  end

  def random_bin
    rand(0...@bins)
  end

  def expected
    @bins * Math.log(@bins)
  end

  def actual
    @results.reduce(&:+).to_f / @rounds.to_f
  end

  def difference
    (expected - actual).abs
  end

  def report
    puts "Expected: #{expected.truncate(2)}"
    puts "Actual: #{actual.truncate(2)}"
    puts "Difference: #{difference.truncate(2)}"
  end
end


require 'pry'
binding.pry

