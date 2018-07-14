require 'minitest/autorun'
require_relative 'inherited_code2'

module BicycleInterfaceTest
  def test_responds_to_default_tire_size
    assert_respond_to(@object, :default_tire_size)
  end

  def test_responds_to_default_chain
    assert_respond_to(@object, :default_chain)
  end

  def test_responds_to_chain
    assert_respond_to(@object, :chain)
  end

  def test_responds_to_size
    assert_respond_to(@object, :size)
  end

  def test_responds_to_tire_size
    assert_respond_to(@object, :tire_size)
  end

  def test_responds_to_spares
    assert_respond_to(@object, :spares)
  end
end

# making sure that the more optional methods from the
# superclass don't get broken by the subclasses.
module BicycleSubclassTest
   def test_responds_to_post_initialize
     assert_respond_to(@object, :post_initialize)
   end

   def test_responds_to_local_spares
     assert_respond_to(@object, :local_spares)
   end

   def test_responds_to_default_tire_size
     assert_respond_to(@object, :default_tire_size)
   end
end

class BicycleTest < MiniTest:: Test
  include BicycleInterfaceTest
  def setup
    @bike = @object = Bicycle.new({tire_size: 0})
  end

  def test_forces_subclasses_to_implement_default_tire_size
    # check if error is thrown when default tire size is not
    # implemented
    assert_raises(MethodNotImplemented) {@bike.default_tire_size}
  end
end

class RoadBikeTest < MiniTest::Test
  include BicycleInterfaceTest # Liskov: act like a bicycle
  include BicycleSubclassTest # also act like a subclass of bicycle

  def setup
    @bike = @object = RoadBike.new
  end
end

class MountainbikeTest < MiniTest::Test
  include BicycleInterfaceTest # Liskov: act like a bicycle
  include BicycleSubclassTest # also act like a subclass of bicycle

  def setup
    @bike = @object = Mountainbike.new
  end
end