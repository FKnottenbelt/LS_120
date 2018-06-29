# implementing spares the easy way (but produces thighter coupling)
# and see here the trouble of knowing to much about super
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

  def spares
    { tire_size: tire_size,
      chain: chain }
  end
end

class RoadBike < Bicycle
  attr_reader :tape_color

  def initialize(args)
    @tape_color = args[:tape_color]
    super(args)
  end

  def default_tire_size # subclass default
    '23'
  end

  def spares
    super.merge({tape_color: tape_color})
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

class RecumbentBike < Bicycle  # new
  attr_reader :flag

  def initialize(args)
    @flag = args[:flag] # forgot to send to super
  end

  def spares
    super.merge({ flag: flag })
  end

  def default_chain
    '9-speed'
  end

  def default_tire_size
    '28'
  end
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
p mountain_bike.spares
# {:tire_size=>"2.1", :chain=>"10-speed", :rear_shock=>"Fox"}
p road_bike.tire_size
p road_bike.chain
p mountain_bike.tire_size
p mountain_bike.chain
# "23"
# "10-speed"
# "2.1"
# "10-speed"
p bent = RecumbentBike.new(flag: 'tall and orange')
p bent.spares
#<RecumbentBike:0x000000018a8f08 @flag="tall and orange">
#{:tire_size=>nil, :chain=>nil, :flag=>"tall and orange"}