=begin
Building on the prior vehicles question, we now must also track a basic
motorboat. A motorboat has a single propeller and hull, but otherwise
behaves similar to a catamaran. Therefore, creators of Motorboat instances
don't need to specify number of hulls or propellers. How would you modify
the vehicles code to incorporate a new Motorboat class?

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

class Catamaran
  include Moveable

  attr_accessor :propeller_count, :hull_count

  def initialize(num_propellers, num_hulls, km_traveled_per_liter,
                 liters_of_fuel_capacity)
    self.fuel_efficiency = km_traveled_per_liter
    self.fuel_capacity = liters_of_fuel_capacity

    # ... other code to track catamaran-specific data omitted ...
  end
end
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

p cat.range # 640.0
p auto.range # 1250.0
p mb.range # 320.0
p cat.hull_count # 2
p mb.hull_count # 1
