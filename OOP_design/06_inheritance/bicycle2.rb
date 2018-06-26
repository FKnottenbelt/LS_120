# adding mountain bike to the mix
class Bicycle
  attr_reader :size, :tape_color, :style, :front_shock, :rear_shock

  def initialize(args)
    @style = args[:style]
    @size = args[:size]
    @tape_color = args[:tape_color]
    @front_shock = args[:front_shock]
    @rear_shock = args[:rear_shock]
  end

  # checking style (missing subclass pattern)
  # and the else will give unexpected results for the 'normal' bike
  def spares
    if style == :road
      { chain: '10-speed',
        tire_size: '23',
        tape_color: tape_color }
    else
      { chain: '10-speed',
        tire_size: '2.1',
        rear_shock: rear_shock }
    end
  end
end

bike = Bicycle.new( size: 'M', tape_color: 'red')
p bike.size
p bike.spares

bike = Bicycle.new(
  style: 'Mountain', size: 'S', front_shock: 'Manitou', rear_shock: 'Fox')
p bike.size
p bike.spares

# "M"
# {:chain=>"10-speed", :tire_size=>"2.1", :rear_shock=>nil}
# "S"
# {:chain=>"10-speed", :tire_size=>"2.1", :rear_shock=>"Fox"}