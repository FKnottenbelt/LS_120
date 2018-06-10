class MyCar
  attr_accessor :color, :model, :speed
  attr_reader :year

  def initialize(year, color, model)
    @year = year
    @color = color
    @model = model
    @speed = 0
  end

  def self.milage(gallons, miles)
    puts "#{miles / gallons} miles per gallon of gas"
  end

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

  def spray_paint(new_color)
    self.color = new_color
  end


end

car = MyCar.new(2018, 'red', 'Ford')
MyCar.milage(13, 351)
puts car