class Gear
  attr_reader :chainring, :cog, :wheel

  def initialize(chainring, cog, wheel) # order is fixed
    @chainring = chainring
    @cog = cog
    @wheel = wheel

  end
end

Gear.new(52, 11, Wheel.new(26, 1.5)).gear_inches

# solution
class Gear
  attr_reader :chainring, :cog, :wheel

  def initialize(args) # hash: no fixed order
    @chainring = args[:chainring]
    @cog = args[:cog]
    @wheel = args[:wheel]

  end
end

# selfdocumenting interface
Gear.new(chainring: 52, cog: 11, wheel: Wheel.new(26, 1.5)).gear_inches
