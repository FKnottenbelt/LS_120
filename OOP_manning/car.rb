# car.rb (manning 5.2.5)

class Car
  @@make = []
  @@cars = Hash.new{0}
  @@total_count = 0

  attr_accessor :make

  def initialize(make)
    if @@make.include?(make)
      puts "Creating new #{make}!"
    else
      raise "No such make: #{make}"
    end
    @make = make
    @@cars[@make] += 1
    @@total_count += 1
  end

  def self.add_make(make)
    @@make << make
  end

  def self.total_count
    @@total_count
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

# official solution
class Car
  @@makes = []
  @@cars = {}
  @@total_count = 0

  attr_reader :make

  def self.total_count
    @@total_count
  end

  def self.add_make(make)
    unless @@makes.include?(make)
      @@makes << make
      @@cars[make] = 0
    end
  end

  def initialize(make)
    if @@makes.include?(make)
      puts "Creating a new #{make}!"
      @make = make
      @@cars[make] += 1
      @@total_count += 1
    else      raise "No such make: #{make}."
    end
  end
  def make_mates
    @@cars[self.make]
  end
end

