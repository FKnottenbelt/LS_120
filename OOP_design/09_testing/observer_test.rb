require 'minitest/autorun'
require_relative 'observer'

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

class DiameterDouble
  def diameter
    10
  end
end

class GearTest < MiniTest::Test
# setting up a Mock to test wether command message gets send
  def setup
    @observer = MiniTest::Mock.new
    @gear = Gear.new(chainring: 52, cog: 11,
                    wheel: DiameterDouble.new,
                    observer: @observer)
  end

  def test_notifies_observer_when_cogs_change
    # .expect(name, retval, args=[]) – Expect that method name is
    # called, optionally with args or a blk, and returns retval. 
    @observer.expect(:changed, true,[52, 27]) # priming Mock
    @gear.set_cog(27) # triggering behaviour
    @observer.verify # see if message was send
  end

  def test_notifies_observer_when_chainrings_change
    @observer.expect(:changed, true,[52,42]) # priming Mock
    @gear.set_cog(42) # triggering behaviour
    @observer.verify # see if message was send
  end

  def test_calculates_gear_inches
    gear = Gear.new(chainring: 52, cog: 11, # do I still need this?
                    wheel: DiameterDouble.new)

    assert_in_delta(47.27,gear.gear_inches, 0.9)
  end
end

