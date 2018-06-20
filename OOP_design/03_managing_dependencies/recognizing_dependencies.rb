class Gear
  attr_reader :chainring, :cog, :rim, :tire # know about rims and tires

  def initialize(chainring, cog, rim, tire) # know about rims and tires
    @chainring = chainring
    @cog = cog
    @rim = rim
    @tire = tire
  end

  def ratio
    chainring / cog.to_f
  end

  def gear_inches  # know about Wheel and the arguments it needs
                   # plus in what order and knows the message name
    ratio * Wheel.new(rim, tire).diameter
  end
end

class Wheel
  attr_reader :rim, :tire

  def initialize(rim, tire)
    @rim = rim
    @tire = tire
  end

  def diameter
    rim + (tire * 2)
  end

  def circumference
    diameter * Math::PI
  end
end