# Testing

Most programmers write too many test. Test everything just once and in
the proper place

The tests you write should be for messages that are defined in the
public interfaces

## What to test
- Incomming messages should be tested for the state they return
- Outgoing command messages should (only) be tested to ensure that they
  get send (with the correct parameters)
- Outgoing query messages should not be tested


state (here): return value
command message: has side effects (a file gets written, a database
record is saved, an action is taken by an observer etc)
query message: asking for state => is tested by receiving object.

## How to test

### Testing incomming messages
Your test should remain as ignorant as possible about context
(everything that is not the object under test)
```ruby
require 'minitest/autorun'
require_relative 'incomming_messages'

class WheelTest < MiniTest::Test

  def test_calculate_diameter
    wheel = Wheel.new(26, 1.5)

    assert_in_delta(29, wheel.diameter, 0.01)
  end
end
```

Delete unused interfaces (incomming messages that has no dependents)
Yes, really. Unused code costs more to keep than to recover.

When the code in your tests uses the same collaborating objects
as the code in your application, your tests always break when they
should.
```ruby
class GearTest < MiniTest::Test

  def test_calculates_gear_inches
    gear = Gear.new(chainring: 52, cog: 11,
                    wheel: Wheel.new(26, 1.5))

    assert_in_delta(137,gear.gear_inches, 0.9)
  end
end
```
If you have *dependency injection* and you have only one canditate
for the role this makes sense.
However, it can be slow. And if you have many candidates you don't
want to have to inject all of them in your test.

Solution: make a fake one, a **test double (stub)** that gives only what
you need. (see test_double.rb)
- the test double is it's own class (e.g. DiameterDouble)
  ```ruby
  class DiameterDouble
    def diameter
      10
    end
  end
  ```
- the test double fills a role (Diameterizable). Make a module
  that test the implementation of this roll and include that
  for all objects that fill that role plus in the test for the
  class that is on 'the other side' of the interface: the one
  injecting the dependency
  ```ruby
  module DiameterizableInterfaceTest
    def test_implements_the_diameterizable_interface
      assert_respond_to(@object, :diameter)
    end
  end

  class WheelTest < MiniTest::Test
    include DiameterizableInterfaceTest

    def setup # implement module by adding @object
      @wheel = @object = Wheel.new(26, 1.5)
    end
  end

  ```
- the test double is an object implementing the role and thus
  needs its own testclass that checks wether it implements the role
  ```ruby
  class DiameterDoubleTest < MiniTest::Test
    include DiameterizableInterfaceTest
    def setup
      @object = DiameterDouble.new
    end
  end
  ```
see OOP_design/09_testing/role_tests_test.rb

## Testing private messages
Never write private messages if you can help it. And if you do,
never test them, unless of course it makes sense to do so. Therefore,
be biased against writing these test but do not fear to do so if
this would improve your lot.

## Testing outgoing messages
Don't test query messages.
Use **Mocks** to prove your outgoing command messages get send.
(see observer_test.rb)
```ruby
class GearTest < MiniTest::Test
# setting up a Mock to test wether command message gets send
  def setup
    @observer = MiniTest::Mock.new
    @gear = Gear.new(chainring: 52, cog: 11,
                    wheel: DiameterDouble.new,
                    observer: @observer)
  end

  def test_notifies_observer_when_cogs_change
    # .expect(name, returnvalue, args=[])
    @observer.expect(:changed, true,[52, 27]) # priming Mock
    @gear.set_cog(27) # triggering behaviour
    @observer.verify # see if message was send
  end
```

## Testing Inherited Code
### specifying the Inherited interface (Liskov)
The first goal is to prove that all objects in the hierachy
honor their contract. The Liskov Subtitution Principle says
that subtypes should be substituable for their supertypes.
The easiest way to prove that every object in the hierachy
obeys **Liskov** is to write a shared test module for the common
contract (e.q. what it means to be a bicycle) and to include
this test in every object.
(see inherited_code_test.rb)
```ruby
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

  ## etc
end

# using the 'does it act like a bicycle' test in the concrete
# subclass Roadbike
class RoadBikeTest < MiniTest::Test
  include BicycleInterfaceTest
  def setup
    @bike = @object = RoadBike.new
  end
end
```
NB: you should also include this test in the superclass.

### Specifying Subclass Responsibilities
#### confirming sublass behaviour
You should also have a module that proves that each subclass acts
like a proper subclass should. This is basically looking at the
messages the subclass can override to make sure they don't break them
```ruby
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
```
Your subclasses should thus include 2 modules, because every subclass
should act both as the superclass and like the subclass.
```ruby
class RoadBikeTest < MiniTest::Test
  include BicycleInterfaceTest # Liskov: act like a bicycle
  include BicycleSubclassTest # also act like a subclass of bicycle

  def setup
    @bike = @object = RoadBike.new
  end
end
```
(see inherited_code_test2.rb)

#### confirming superclass enforcement
If the superclass enforces implementation by raising errors,
the raising of this error has to be tested.
We do this using `assert_raises(<error>) {<@object.method>}`
```ruby
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
```

### Testing Unique Behaviour
### Testing concrete subclass behaviour
The shared modules allready prove most of the behaviour. The only
thing left is to test the specialisations. But without embedding
knowlegde of hte superclass in the test.
```ruby
class RoadBikeTest < MiniTest::Test
  include BicycleInterfaceTest # Liskov: act like a bicycle
  include BicycleSubclassTest # also act like a subclass of bicycle

  def setup
    @bike = @object = RoadBike.new(tape_color: 'red')
  end

  # test for RoadBike specialisations
  def test_puts_tape_color_in_local_spares
    assert_equal 'red', @bike.local_spares[:tape_color]
  end
end
```
(see inherited_code_test3)

### Testing abstract superclass behaviour
Since testing an abstract superclass behaviour can be
difficult (due to not being able to initialize properly)
it can be helpfull to create a sub for the superclass that
supplies the behaviour of the subclasses.
