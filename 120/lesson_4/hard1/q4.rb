=begin
The designers of the vehicle management system now want to make an
adjustment for how the range of vehicles is calculated. For the seaborne
vehicles, due to prevailing ocean currents, they want to add an additional
10km of range even if the vehicle is out of fuel.

Alter the code related to vehicles so that the range for autos and
motorcycles is still calculated as before, but for catamarans and
motorboats, the range method will return an additional 10km.
=end

module Moveable
  attr_accessor :speed, :heading
  attr_writer :fuel_capacity, :fuel_efficiency

  def range
    @fuel_capacity * @fuel_efficiency
  end
end

class WheeledVehicle
  include Moveable

  def initialize(tire_array, km_traveled_per_liter, liters_of_fuel_capacity)
    @tires = tire_array
    self.fuel_efficiency = km_traveled_per_liter
    self.fuel_capacity = liters_of_fuel_capacity
  end

  def tire_pressure(tire_index)
    @tires[tire_index]
  end

  def inflate_tire(tire_index, pressure)
    @tires[tire_index] = pressure
  end
end

class Auto < WheeledVehicle
  def initialize
    # 4 tires are various tire pressures
    super([30,30,32,32], 50, 25.0)
  end
end

class Motorcycle < WheeledVehicle
  def initialize
    # 2 tires are various tire pressures
    super([20,20], 80, 8.0)
  end
end

class Boat
  include Moveable

  attr_accessor :propeller_count, :hull_count

  def initialize(args)
    self.fuel_efficiency = args[:km_traveled_per_liter]
    self.fuel_capacity = args[:liters_of_fuel_capacity]
    self.propeller_count = args[:num_propellers] || default_prop_count
    self.hull_count = args[:num_hulls] || default_num_hulls
  end

  def default_prop_count
    raise("default propeller count not implemented")
  end

  def default_num_hulls
    raise("default number of hulls not implemented")
  end

  def range
    extra_miles_due_to_currents = 10
    super + extra_miles_due_to_currents
  end
end

class Catamaran < Boat
end

class Moterboat < Boat
  def default_prop_count
    self.propeller_count = 1
  end

  def default_num_hulls
    self.hull_count = 1
  end
end

cat = Catamaran.new(num_propellers: 2,
                    num_hulls: 2,
                    km_traveled_per_liter: 80,
                    liters_of_fuel_capacity: 8.0)
auto = Auto.new
mb = Moterboat.new( km_traveled_per_liter: 80,
                    liters_of_fuel_capacity: 4.0)

p cat.range # 650.0
p auto.range # 1250.0
p mb.range # 330.0

# just overiding range and adding 10 km. Didn't thing that would
# allowed, but there you go...
# ls:
  # the following is added to the existing Seacraft definition
  # def range
  #   range_by_using_fuel = super
  #   return range_by_using_fuel + 10
  # end