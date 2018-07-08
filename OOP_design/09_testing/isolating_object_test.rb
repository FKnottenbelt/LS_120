require 'minitest/autorun'
require_relative 'isolating_object'

class WheelTest < MiniTest::Test

  def test_calculate_diameter
    wheel = Wheel.new(26, 1.5)

    assert_in_delta(29, wheel.diameter, 0.01)
  end
end

class GearTest < MiniTest::Test

  def test_calculates_gear_inches
    gear = Gear.new(chainring: 52, cog: 11,
                    wheel: Wheel.new(26, 1.5))

    assert_in_delta(137,gear.gear_inches, 0.9)
  end
end