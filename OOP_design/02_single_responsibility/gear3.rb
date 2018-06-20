class Gear
  def initialize(chainring, cog)
    @chainring = chainring
    @cog = cog
  end

  def ratio
    @chainring / @cog.to_f           # <= road to ruin
  end

end

# correct version:

class Gear
  attr_reader :chainring, :cog      # <= wrap in method

  def initialize(chainring, cog)
    @chainring = chainring
    @cog = cog
  end

  def ratio
    chainring / cog.to_f           # <= reference method
  end

end
