# promoting size to Bicycle

class Bicycle
  attr_reader :size

  def initialize(args)
    @size = args[:size]
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

  def spares
    super.merge(rear_shock: rear_shock)
  end
end

road_bike = RoadBike.new(size: 'M', tape_color: 'red')
p road_bike.size
mountain_bike = Mountainbike.new(
                  size: 'S',
                  front_shock: 'Manitou',
                  rear_shock: "Fox")
p mountain_bike.size