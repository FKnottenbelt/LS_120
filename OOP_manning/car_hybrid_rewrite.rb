# car_hybrid_rewrite.rb

class Car
  @@make = []
  @@cars = Hash.new{0}

  attr_accessor :make

  def initialize(make)
    if @@make.include?(make)
      puts "Creating new #{make}!"
    else
      raise "No such make: #{make}"
    end
    @make = make
    @@cars[@make] += 1
    self.class.total_count += 1
  end

  def self.total_count
    @total_count ||= 0
  end

  def self.total_count=(n)
    @total_count = n
  end

  def self.add_make(make)
    @@make << make
  end

  def make_mates
    @@cars[@make]
  end

end

Car.add_make("Honda")
Car.add_make("Ford")
h = Car.new("Honda")
f = Car.new("Ford")
h2 = Car.new("Honda")
#x = Car.new("Brand X")
puts "Counting cars of same make as h2..."
puts "There are #{h2.make_mates}."
puts "Counting total cars..."
puts "There are #{Car.total_count}."

class Hybrid < Car
end

hy = Hybrid.new('Honda')
puts "there are #{Hybrid.total_count} hybrids in existence"
# => 1
# @total_count is now class instance variable