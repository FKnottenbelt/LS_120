# giving the Parts class a Part object class
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

class Parts
  attr_reader :parts # holds an array of all the parts for a bike object

  def initialize(parts)
    @parts = parts
  end

  def spares # @parts is an array of part objects
    parts.select{ |part| part.needs_spare } # gives array of
                            # part objects that need spares
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


class MethodNotImplemented < StandardError
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
#p mountain_bike.parts.size
# undefined method `size' for #<Part => returns instantance of Parts
p mountain_bike.parts.parts.size # 4