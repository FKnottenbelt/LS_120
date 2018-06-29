# Fix the following code so it works properly:
#
# class Car
#   attr_accessor :mileage
#
#   def initialize
#     @mileage = 0
#   end
#
#   def increment_mileage(miles)
#     total = mileage + miles
#     mileage = total
#   end
#
#   def print_mileage
#     puts mileage
#   end
# end
#
# car = Car.new
# car.mileage = 5000
# car.increment_mileage(678)
# car.print_mileage  # should print 5678

class Car
  attr_accessor :mileage

  def initialize
    @mileage = 0
  end

  def increment_mileage(miles)
    total = mileage + miles
    self.mileage = total
  end

  def print_mileage
    puts mileage
  end
end

car = Car.new
car.mileage = 5000
car.increment_mileage(678)
p car.mileage
car.print_mileage  # should print 5678

# mileage = total sets a local variable
# To access the setter method, we need to provide an explicit receiver
# self.mileage = total (or refer to the instance variable directly:
# @mileage = total,  but self is better)