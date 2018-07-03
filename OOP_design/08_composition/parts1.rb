# adding Parts and moving most Bicycle code to Parts. Other bikes are
# now bikeparts and inherit from parts
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
  attr_reader :chain, :tire_size

  def initialize(args={})
    @chain = args[:chain] || default_chain
    @tire_size = args[:tire_size] || default_tire_size
    post_initialize(args)
  end

  def spares
    { tire_size: tire_size,
      chain: chain }.merge(local_spares)
  end

  def default_tire_size
    raise MethodNotImplemented,
    "This #{self.class} cannot respond to default_tire_size"
  end

  # subclasses may override this hook messages:
  def post_initialize(args)
    nil
  end

  def local_spares
    {}
  end

  def default_chain # common default. can be overridden by subclass
    '10-speed'
  end
end

class RoadBikeParts < Parts
  attr_reader :tape_color

  def post_initialize(args)  #changed to post_intialize (overriding super)
    @tape_color = args[:tape_color]
  end

  def default_tire_size # subclass default
    '23'
  end

  def local_spares # overriding hook
    { tape_color: tape_color }
  end
end

class MountainbikeParts < Parts
  attr_reader :front_shock, :rear_shock

  def post_initialize(args)
    @front_shock = args[:front_shock]
    @rear_shock = args[:rear_shock]
  end

  def default_tire_size # subclass default
    '2.1'
  end

  def local_spares
    { rear_shock: rear_shock }
  end
end

class MethodNotImplemented < StandardError
end

class RecumbentBikeParts < Parts
  attr_reader :flag

  def post_initialize(args)
    @flag = args[:flag]
  end

  def local_spares
    { flag: flag }
  end

  def default_chain
    '9-speed'
  end

  def default_tire_size
    '28'
  end
end


road_bike = Bicycle.new(size: 'M',
              parts: RoadBikeParts.new(tape_color: 'red'))
p road_bike.size
p road_bike.spares
# {:chain=>"10-speed", :tire_size=>"23", :tape_color=>"red"}

mountain_bike = Bicycle.new(
                  size: 'S',
                  parts: MountainbikeParts.new(front_shock: 'Manitou',
                  rear_shock: "Fox"))
p mountain_bike.size
p mountain_bike.spares
# {:tire_size=>"2.1", :chain=>"10-speed", :rear_shock=>"Fox"}

