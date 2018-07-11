require 'minitest/autorun'
require_relative 'testing_ducktypes'

# using a module to share the tests for the Preparers Role
module PreparerInterfaceTest
  def test_implement_the_preparer_interface
    assert_respond_to(@object, :prepare_trip)
  end
end

# test if Mechanic implements Prperarers interface
# all incomming messages are tested (Mechanic, Trip, Driver)
class MechanicTest < MiniTest::Test
  include PreparerInterfaceTest  # <== include module

  def setup
    @mechanic = @object = Mechanic.new # <== trigger test
  end
end

class TripCoordinatorTest < MiniTest::Test
  include PreparerInterfaceTest

  def setup
    @trip_coordinator = @object = TripCoordinator.new
  end
end

class DriverTest < MiniTest::Test
  include PreparerInterfaceTest

  def setup
    @driver = @object = Driver.new
  end
end

# Also test outgoing command message to see that message is send
# (by using a Mock)
class TripTest < MiniTest::Test

  def test_request_trip_prepartion
    @preparer = MiniTest::Mock.new
    @trip = Trip.new
    @preparer.expect(:prepare_trip, nil, [@trip])
    @trip.prepare([@preparer])
    @preparer.verify
  end
end


