class Wheel
  attr_reader :rim, :tire

  def initialize(rim, tire)
    @rim = rim
    @tire = tire
  end

  def diameter  # <== change from diameter to width
    rim + (tire * 2)
  end
end

class Gear
  attr_reader :chainring, :cog, :wheel, :observer

  def initialize(args)
    @chainring = args[:chainring]
    @cog = args[:cog]
    @wheel = args[:wheel]
    @observer = args[:observer]
  end

  def set_cog(new_cog)
    @cog = new_cog
    changed
  end

  def set_chainring(new_chainring)
    @chainring = new_chainring
    changed
  end

  def changed # outgoing command messages to Observer
    observer.changed(chainring, cog)
  end

  def ratio # incomming
    chainring / cog.to_f
  end

  def gear_inches # incomming. The object in the wheel
    # variable plays the diameterizable role.
    ratio * wheel.diameter  #<== obsolete
  end
end