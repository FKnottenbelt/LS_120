# when diameter in Wheel changes, but it does not change
# in Gear, the test fails as it should
# (the interface of the Diameterizable changed!)

class Wheel
  attr_reader :rim, :tire

  def initialize(rim, tire)
    @rim = rim
    @tire = tire
  end

  def width # <= used to be diameter
    rim + (tire * 2)
  end
end

class Gear
  attr_reader :chainring, :cog, :wheel

  def initialize(args)
    @chainring = args[:chainring]
    @cog = args[:cog]
    @wheel = args[:wheel]
  end

  def ratio # incomming
    chainring / cog.to_f
  end

  def gear_inches
    ratio * wheel.diameter # <= obsolete
  end
end