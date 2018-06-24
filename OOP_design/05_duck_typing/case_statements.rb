# example of duck type in hiding:
class Trip
  attr_reader :bicycles, :customers, :vehicle

  def prepare(preparers)
    preparers.each do |preparer|
      case preparer
      when Mechanic
        preparer.prepare_bicycles(bicycles)
      when TripCoordinator
        preparer.buy_food(customers)
      when Driver
        preparer.gas_up(vehicle)
        preparer.fill_water_tank(vehicle)
      end
    end
  end
end

# duck type solution:
class Trip
  attr_reader :bicycles, :customers, :vehicle

  def prepare(preparers)
    preparers.each do |preparer|
      preparer.prepare.trip(self)
    end
  end
end

# every preparer is a duck that responds to prepare_trip
class Mechanic
  def prepare_trip(trip)
    trip.bicyclese.each do |bicycle|
      prepare_trip(bicycle)
    end
  end
end
