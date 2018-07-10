# we need to test the Gear incomming message 'gear-inches' that uses
# wheel.diameter. We are injecting a wheel like object and using a
# stub to provide the wheel like object with a diameter of 10

class Wheel
  attr_reader :rim, :tire

  def initialize(rim, tire)
    @rim = rim
    @tire = tire
  end

  def diameter
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

  def gear_inches # incomming
    ratio * wheel.diameter
  end
end