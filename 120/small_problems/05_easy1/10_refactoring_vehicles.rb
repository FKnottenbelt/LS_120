# Consider the following classes:
#
# class Car
#   attr_reader :make, :model
#
#   def initialize(make, model)
#     @make = make
#     @model = model
#   end
#
#   def wheels
#     4
#   end
#
#   def to_s
#     "#{make} #{model}"
#   end
# end
#
# class Motorcycle
#   attr_reader :make, :model
#
#   def initialize(make, model)
#     @make = make
#     @model = model
#   end
#
#   def wheels
#     2
#   end
#
#   def to_s
#     "#{make} #{model}"
#   end
# end
#
# class Truck
#   attr_reader :make, :model, :payload
#
#   def initialize(make, model, payload)
#     @make = make
#     @model = model
#     @payload = payload
#   end
#
#   def wheels
#     6
#   end
#
#   def to_s
#     "#{make} #{model}"
#   end
# end
#
# Refactor these classes so they all use a common superclass, and inherit
# behavior as needed.

# assuming wheeled vehicles...:
class Vehicle
  attr_reader :wheels, :make, :model

  def initialize(args={})
    @make = args[:make]
    @model = args[:model]
    @wheels = args[:wheels] || default_wheels
    post_initialise(args)
  end

  def post_initialise(args)
    nil
  end

  def default_wheels
    4
  end

  def to_s
    "#{make} #{model}"
  end
end

class Car < Vehicle
end

class Motorcycle < Vehicle
  def default_wheels
    2
  end
end

class Truck < Vehicle
  def post_initialize(args)
    @payload = args[:payload]
  end

  def default_wheels
    6
  end
end


car = Car.new(make: 2014, model:"Mercedes")
puts car
p car.wheels
truck = Truck.new(make: 2011, model: "Ford", payload: 200)
puts truck
p truck.wheels
motercycle = Motorcycle.new(make: 2017, model: "Yamaha")
puts motercycle
p motercycle.wheels

##################
# LS solution
class Vehicle
  attr_reader :make, :model, :wheels

  def initialize(make, model)
    @make = make
    @model = model
    @wheels = 4
  end

  def to_s
    "#{make} #{model}"
  end
end

class Car < Vehicle
end

class Motorcycle < Vehicle
  def initialize(make, model)
    super(make, model)
    @wheels = 2
  end
end

class Truck < Vehicle
  attr_reader :payload

  def initialize(make, model, payload)
    super(make, model)
    @wheels = 6
    @payload = payload
  end
end
