# starting to sort out spares: seperating Abstract from Concrete
class Bicycle
  attr_reader :size, :chain, :tire_size

  def initialize(args={}) # note the default empty hash
    @size = args[:size]
    @chain = args[:chain] || default_chain
    @tire_size = args[:tire_size] || default_tire_size
  end

  def default_chain # common default. can be overridden by subclass
    '10-speed'
  end

  # default_tire_size is not implemented here so MUST be implemented
  # in the subclasses. So at least give a hint:
  def default_tire_size
    raise MethodNotImplemented,
    "This #{self.class} cannot respond to default_tire_size"
  end
end

class RoadBike < Bicycle
  attr_reader :tape_color, :style, :front_shock, :rear_shock

  def initialize(args)
    @style = args[:style]
    @tape_color = args[:tape_color]
    @front_shock = args[:front_shock]
    @rear_shock = args[:rear_shock]
    super(args)
  end

  def default_tire_size # subclass default
    '23'
  end

  def spares
    { chain: '10-speed',
      tire_size: '23',
      tape_color: tape_color }
  end
end

class Mountainbike < Bicycle
  attr_reader :front_shock, :rear_shock

  def initialize(args)
    @front_shock = args[:front_shock]
    @rear_shock = args[:rear_shock]
    super(args)
  end

  def default_tire_size # subclass default
    '2.1'
  end

  def spares
    super.merge(rear_shock: rear_shock)
  end
end

class MethodNotImplemented < StandardError
end

class RecumbentBike < Bicycle
end


road_bike = RoadBike.new(size: 'M', tape_color: 'red')
p road_bike.size
mountain_bike = Mountainbike.new(
                  size: 'S',
                  front_shock: 'Manitou',
                  rear_shock: "Fox")
p mountain_bike.size

p road_bike.spares
# {:chain=>"10-speed", :tire_size=>"23", :tape_color=>"red"}
#p mountain_bike.spares

p road_bike.tire_size
p road_bike.chain
p mountain_bike.tire_size
p mountain_bike.chain
# "23"
# "10-speed"
# "2.1"
# "10-speed"
p bent = RecumbentBike.new
# bicycle6.rb:18:in `default_tire_size': This RecumbentBike cannot respond
# to default_tire_size (MethodNotImplemented)