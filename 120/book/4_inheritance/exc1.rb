
# A vehicle is a machine that transports people or cargo. Typical vehicles
# include wagons, bicycles, motor vehicles, railed vehicles, watercraft,
# aircraft and spacecraft.

module Fuelable
  def milage(gallons, miles)
    puts "#{miles / gallons} miles per gallon of gas"
  end
end

class Vehicle
  attr_accessor :color, :model, :speed
  attr_reader :year

  def initialize(year, color, model)
    @year = year
    @color = color
    @model = model
    @speed = 0
  end

  def spray_paint(new_color)
    self.color = new_color
  end

end

class MyCar < Vehicle
  NO_OF_DOORS = 4
  include Fuelable

  def to_s
    puts "This car is a #{model} from #{year} and has the color #{color}"
  end

  def speedup(n)
    self.speed += n
  end

  def brake(n)
    self.speed -= n
  end

  def shutoff
    self.speed = 0
  end

end

class MyTruck < Vehicle
  NO_OF_DOORS = 2
  include Fuelable

  def to_s
    puts "This truck is a #{model} from #{year} and has the color #{color}"
  end
end

car = MyCar.new(2018, 'red', 'Ford')
truck = MyTruck.new(2010, 'blue', 'Toyota')
car.milage(13, 351)
truck.milage(5, 351)
puts car
puts truck