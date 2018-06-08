class MyCar
  attr_accessor :color, :model, :speed
  attr_reader :year

  def initialize(year, color, model)
    @year = year
    @color = color
    @model = model
    @speed = 0
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

  def spray_paint
  end
end

car = MyCar.new(2018, 'red', 'Ford')

p car
p car.speed
car.speedup(50)
p car.speed
car.brake(20)
p car.speed
car.shutoff
p car.speed
p car.color
p car.year
car.speed = 100
p car.speed
#car.year = 2010
