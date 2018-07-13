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
The first goal is to prove that all objects in the hierachy
honor their contract. The Liskov Subtitution Principle says
that subtypes should be substituable for their supertypes.
The easiest way to prove that every object in the hierachy
obeys Liskov is to write a shared test module for the common
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
