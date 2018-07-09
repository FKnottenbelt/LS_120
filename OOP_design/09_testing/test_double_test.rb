require 'minitest/autorun'
require_relative 'test_double'

# Creating a test double to stub the Diameterizable role'
class DiameterDouble
  def diameter
    10
  end
end

class GearTest < MiniTest::Test

  def test_calculates_gear_inches
    gear = Gear.new(chainring: 52, cog: 11,
                    wheel: DiameterDouble.new)

    assert_in_delta(47.27,gear.gear_inches, 0.9)
  end
end

