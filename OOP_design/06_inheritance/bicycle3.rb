  def spares
    { chain: '10-speed',
      tire_size: '23',
      tape_color: tape_color }
  end# subclassing mountainbike the wrong way
# overriding initialize and spares
class Bicycle
  attr_reader :size, :tape_color, :style, :front_shock, :rear_shock

  def initialize(args)
    @style = args[:style]
    @size = args[:size]
    @tape_color = args[:tape_color]
    @front_shock = args[:front_shock]
    @rear_shock = args[:rear_shock]
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

bike = Bicycle.new( size: 'M', tape_color: 'red')
p bike.size
p bike.spares

# "M"
# {:chain=>"10-speed", :tire_size=>"2.1", :rear_shock=>nil}

mountain_bike = Mountainbike.new(
                  size: 'S',
                  front_shock: 'Manitou',
                  rear_shock: "Fox")
p mountain_bike.size
p mountain_bike.spares
# "S"
# {:chain=>"10-speed", :tire_size=>"23", :tape_color=>nil, :rear_shock=>"Fox"}