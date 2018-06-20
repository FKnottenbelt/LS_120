class Gear
  attr_reader :chainring, :cog, :rim, :tire

  def initialize(chainring, cog, rim, tire)
    @chainring = chainring
    @cog = cog
    @rim = rim
    @tire = tire
  end

  def ratio
    chainring / cog.to_f
  end

  def gear_inches
    ratio * Wheel.new(rim, tire).diameter  # Knows Wheel name
  end

end

p Gear.new(52,11, 26, 1.5).gear_inches

# solution:

class Gear
  attr_reader :chainring, :cog, :wheel # an oject, any object that responds
                                       # to diameter

  def initialize(chainring, cog, wheel)
    @chainring = chainring
    @cog = cog
    @wheel = wheel
  end

  def ratio
    chainring / cog.to_f
  end

  def gear_inches
    ratio * wheel.diameter
  end

end