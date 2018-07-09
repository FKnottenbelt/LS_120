# proving that wheel plays the role of diameterizable
# and documenting the role in the proces
require 'minitest/autorun'
require_relative 'document_role'

class WheelTest < MiniTest::Test
  def setup
    @wheel = Wheel.new(26, 1.5)
  end

  def test_implements_the_diameterizable_interface
    assert_respond_to(@wheel, :diameter)
  end

  def test_calculate_diameter
    wheel = Wheel.new(26, 1.5)

    assert_in_delta(29, wheel.diameter, 0.01)
  end
end

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

