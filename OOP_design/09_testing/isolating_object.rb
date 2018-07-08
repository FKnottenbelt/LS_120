class Wheel
  attr_reader :rim, :tire

  def initialize(rim, tire)
    @rim = rim
    @tire = tire
  end

  def diameter # incomming
    rim + (tire * 2)
  end

  def circumference
    diameter * Math::PI
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

  def gear_inches   # incomming
    # the object in the wheel variable plays the 'Diameterizable'
    # role
    ratio * wheel.diameter # outgoing
  end

end

