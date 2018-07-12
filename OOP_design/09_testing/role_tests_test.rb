# using a module to test the implementation of the diameteriazble
# interface prevents the test double from giving false positives.
# you can now change the messages name in wheel from diameter to width
# and get the appropriate failures
# change the name of the diameter method in de wheel class and see
# everything fail

require 'minitest/autorun'
require_relative 'role_tests'

module DiameterizableInterfaceTest # make module and move test from
                                   # wheel to here
  def test_implements_the_diameterizable_interface
    assert_respond_to(@object, :diameter)
  end
end

class WheelTest < MiniTest::Test
  include DiameterizableInterfaceTest # include module
  # this makes sure wheel knows it is implementing
  # the role interface.

  def setup # implement module by adding @object
    @wheel = @object = Wheel.new(26, 1.5)
  end

  def test_calculate_diameter
    wheel = Wheel.new(26, 1.5)
    assert_in_delta(29, wheel.diameter, 0.01)
  end
end

class DiameterDouble
  def diameter  # if diameter changes name in wheel (to width, this
                # should fail)
    10
  end
end

# since DiameterDouble stands in for Wheel, it to needs to
# be tested to see if it implements the interface. And thus
# needs it own test class..
class DiameterDoubleTest < MiniTest::Test
  include DiameterizableInterfaceTest
  def setup
    @object = DiameterDouble.new
  end
end

class GearTest < MiniTest::Test
  def setup
    @observer = MiniTest::Mock.new
    @gear = Gear.new(chainring: 52, cog: 11,
                    wheel: DiameterDouble.new,
                    observer: @observer)
  end

  def test_notifies_observer_when_cogs_change
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
    gear = Gear.new(chainring: 52, cog: 11,
                    wheel: DiameterDouble.new) # out of date

    assert_in_delta(47.27,gear.gear_inches, 0.9)
  end
end

