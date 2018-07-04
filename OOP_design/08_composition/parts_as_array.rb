# diversion: parts as array
class Bicycle
  attr_reader :size, :parts

  def initialize(args={})
    @size = args[:size]
    @parts = args[:parts]
  end

  def spares
    parts.spares
  end
end

class Parts < Array
  def spares
    select{ |part| part.needs_spare }
  end
end

class Part
  attr_reader :name, :description, :needs_spare

  def initialize(args)
    @name = args[:name]
    @description  = args[:description]
    @needs_spare = args.fetch(:needs_spare, true)
  end
end


# making part objects
chain = Part.new(name: 'chain', description: '10-speed')
road_tire = Part.new(name: 'tire_size', description: '23')
tape = Part.new(name: 'tape_color', description: 'red')
mountain_tire = Part.new(name: 'tire_size', description: '2.1')
front_shock = Part.new(name: 'front_shock', description: 'Manitou',
                        needs_spare: false)
rear_shock = Part.new(name: 'rear_schock', description: 'Fox')


# optional grouping parts
road_bike_parts = Parts.new([chain, road_tire, tape])

# or doing it at the fly:
road_bike = Bicycle.new(size: 'L',
                        parts: Parts.new([chain, road_tire, tape]))
p road_bike.size
p road_bike.spares

mountain_bike = Bicycle.new(
                  size: 'L',
                  parts: Parts.new([chain, front_shock,
                                    mountain_tire, rear_shock]))
p mountain_bike.size
p mountain_bike.spares


p mountain_bike.spares.size # 3
p mountain_bike.parts.size # 4

# But...
# Parts inherits '+' from Array, so you can add two Parts together
p combo_parts = mountain_bike.parts + road_bike_parts
# => 7 part objects in an array
p combo_parts.size   # => 7
# but the object that '+' returns does not understand 'spares'
#p combo_parts.spares
# => undefined method `spares' for #<Array

p mountain_bike.parts.class # => Parts
p road_bike.parts.class # => Parts
p combo_parts.class # => Array!