# We can create a new class to present the common elements of
# motorboats and catamarans. We can call it, for example, Seacraft.
# We still want to include the Moveable module to get the support
# for calculating the range.

class Seacraft
  include Moveable

  attr_accessor :hull_count, :propeller_count

  def initialize(num_propellers, num_hulls, fuel_efficiency, fuel_capacity)
    self.propeller_count = num_propellers
    self.hull_count = num_hulls
    self.fuel_efficiency = fuel_efficiency
    self.fuel_capacity = fuel_capacity
  end
end

# We can now implement Motorboat based on the Seacraft definition.
# We don't need to include a reference to Moveable since that is
# already included in the Seacraft super class.

class Motorboat < Seacraft
  def initialize(km_traveled_per_liter, liters_of_fuel_capacity)
    # set up 1 hull and 1 propeller
    super(1, 1, km_traveled_per_liter, liters_of_fuel_capacity)
  end
end

# And we alter the Catamaran to inherit from Seacraft and move
# hull and propeller tracking out since it's taken over by Seacraft.
# We can also remove the reference to the Moveable module.

class Catamaran < Seacraft
  def initialize(num_propellers, num_hulls, km_traveled_per_liter, liters_of_fuel_capacity)
    super(num_propellers, num_hulls, km_traveled_per_liter, liters_of_fuel_capacity)
  end
end

# The super method automatically receives and passes along any
# arguments which the original method received. Because of that,
# we can remove the arguments being passed into super:

class Catamaran < Seacraft
  def initialize(num_propellers, num_hulls, km_traveled_per_liter, liters_of_fuel_capacity)
    super
  end
end

# In fact, because super is the only statement in this initialize
# method and there's nothing to override, we can remove it altogether.

class Catamaran < Seacraft
end
######################################3
# so full code:

class Seacraft
  include Moveable

  attr_accessor :hull_count, :propeller_count

  def initialize(num_propellers, num_hulls, fuel_efficiency, fuel_capacity)
    self.propeller_count = num_propellers
    self.hull_count = num_hulls
    self.fuel_efficiency = fuel_efficiency
    self.fuel_capacity = fuel_capacity
  end
end

class Motorboat < Seacraft
  def initialize(km_traveled_per_liter, liters_of_fuel_capacity)
    # set up 1 hull and 1 propeller
    super(1, 1, km_traveled_per_liter, liters_of_fuel_capacity)
  end
end

class Catamaran < Seacraft
end
