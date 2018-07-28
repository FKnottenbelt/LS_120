# Inheritance and Variable Scope

You already know how inheritance affects methods, but what about variables?
Let's go through some examples to understand the behavior.

## Instance Variables

First, we'll look at how sub-classing affects instance variables.
```ruby
class Animal
  def initialize(name)
    @name = name
  end
end

class Dog < Animal
  def dog_name
    "bark! bark! #{@name} bark! bark!"    # can @name be referenced here?
  end
end

teddy = Dog.new("Teddy")
puts teddy.dog_name                     # => bark! bark! Teddy bark! bark!
```
Looks like it! When we instantiated teddy, we called Dog.new. Since the
Dog class doesn't have an initialize instance method, the method lookup
path went to the super class, Animal, and executed Animal#initialize.
That's when the @name instance variable was initialized, and that's why
we can access it from teddy.dog_name.

One small tweak, though, and the story changes.
```ruby
class Animal
  def initialize(name)
    @name = name
  end
end

class Dog < Animal
  def initialize(name); end

  def dog_name
    "bark! bark! #{@name} bark! bark!"    # can @name be referenced here?
  end
end

teddy = Dog.new("Teddy")
puts teddy.dog_name                       # => bark! bark! bark! bark!
```
In this case, @name is nil, because it was never initialized. The
Animal#initialize method was never executed. Remember that uninitialized
instance variables return nil.

Ok, what about mixing in modules? How does that affect instance variables?
```ruby
module Swim
  def enable_swimming
    @can_swim = true
  end
end

class Dog
  include Swim

  def swim
    "swimming!" if @can_swim
  end
end

teddy = Dog.new
teddy.swim                                  # => nil
```
What happened? Since we didn't call the Swim#enable_swimming method,
the @can_swim instance variable was never initialized. Assume the same
module and class from above, we need to do the following
```ruby
teddy = Dog.new
teddy.enable_swimming
teddy.swim                                  # => swimming!
```

From the examples above, instance variables don't really exhibit any
surprising behavior. They behave very similar to how instance methods
would, with the exception that we must first call the method that
initializes the instance variable. Once we've done that, the instance
can access that instance variable.

## Class Variables

Let's now run a few experiments with class variables.
```ruby
class Animal
  @@total_animals = 0

  def initialize
    @@total_animals += 1
  end
end

class Dog < Animal
  def total_animals
    @@total_animals
  end
end

spike = Dog.new
spike.total_animals                           # => 1
```
Great, it looks like class variables are accessible to sub-classes.
Note that since this class variable is initialized in the Animal class,
there is no method to explicitly invoke to initialize it. The class
variable is loaded when the class is evaluated by Ruby. This is pretty
expected behavior.

But there's a potentially huge problem. It can be dangerous when working
with class variables within the context of inheritance, because there is
only one copy of the class variable across all sub-classes. Here's an
example:
```ruby
class Vehicle
  @@wheels = 4

  def self.wheels
    @@wheels
  end
end

Vehicle.wheels                              # => 4
```
That's pretty straight forward: we initialize a class variable, then
expose a class method to return the value of the class variable. Now
let's add a sub-class that overrides this class variable.
```ruby
class Motorcycle < Vehicle
  @@wheels = 2
end

Motorcycle.wheels                           # => 2
Vehicle.wheels                              # => 2  Yikes!
```
For some odd reason, the class variable in the sub-class affected the
class variable in the super class. Worse still, this change will
affect all other sub-classes of Vehicle!
```ruby
class Car < Vehicle
end

Car.wheels                                  # => 2  Not what we expected!
```
If we're writing a new class called Car, it'll be pretty natural to look
at what we can inherit from the Vehicle super-class. We'd notice the
@@wheels = 4 in the Vehicle super-class, and in the spirit of avoiding
repetition, we would assume that class variable would be inherited by
our Car sub-class. The fact that an entirely different sub-class of
Vehicle can somehow modify this class variable throws a wrench into
the way we think about class inheritance.

For this reason, avoid using class variables when working with
inheritance. In fact, some Rubyists would go as far as recommending
avoiding class variables altogether. The solution is usually to use
class instance variables, but that's a topic we aren't ready to talk
about yet.

## Constants

We already saw that constants can be accessed from instance or class
methods when defined within a class. But can we reference a constant
defined in a different class?
```ruby
class Dog
  LEGS = 4
end

class Cat
  def legs
    LEGS
  end
end

kitty = Cat.new
kitty.legs                                  # => NameError: uninitialized constant Cat::LEGS
```
The error occurs here because Ruby is looking for LEGS within the Cat
class. This is expected, since this is the same behavior as class or
instance variables (except, referencing an uninitialized instance
variable will return nil).

But unlike class or instance variables, we can actually reach into the
Dog class and reference the LEGS constant. In order to do so, we have
to tell Ruby where the LEGS constant is using ::, which is the namespace
resolution operator.
```ruby
class Dog
  LEGS = 4
end

class Cat
  def legs
    Dog::LEGS                               # added the :: namespace resolution operator
  end
end

kitty = Cat.new
kitty.legs                                  # => 4
```
Sidenote: you can use :: on classes, modules or constants. We'll talk
more about namespacing classes and modules in the future.

Ok, so far we've only been looking at two unconnected classes, and we
haven't even talked about how constants work with inheritance yet.
Let's take a look at how constants behave in a sub-class.
```ruby
class Vehicle
  WHEELS = 4
end

class Car < Vehicle
  def self.wheels
    WHEELS
  end

  def wheels
    WHEELS
  end
end

Car.wheels                                  # => 4

a_car = Car.new
a_car.wheels                                # => 4
```
That looks like what we're used to by now. A constant initialized in
a super-class is inherited by the sub-class, and can be accessed by
both class and instance methods.

However, things get a little hairy when we mix in modules. Suppose
we have a module that we want to mix in to different vehicles.
```ruby
module Maintenance
  def change_tires
    "Changing #{WHEELS} tires."
  end
end

class Vehicle
  WHEELS = 4
end

class Car < Vehicle
  include Maintenance
end

a_car = Car.new
a_car.change_tires                          # => NameError: uninitialized constant Maintenance::WHEELS
```
Unlike instance methods or instance variables, constants are not
evaluated at runtime, so their lexical scope - or, where they are
used in the code - is very important. In this case, the line "Changing
#{WHEELS} tires." is in the Maintenance module, which is where Ruby will
look for the WHEELS constant. Even though we call the change_tires
method from the a_car object, Ruby is not able to find the constant.

*"runtime" mostly means when your code executes. It's in contrast to
"before runtime", which is a series of steps that the Ruby interpreter
does before your code executes. There are lots of steps, but you can
think of all of them as reading your code and then parsing it into some
structure to ready it for execution. Constants, like class declarations,
are evaluated before runtime. An example is this: write a program that
only declares a class and then execute that program. The "runtime" there
shouldn't do anything because there was no execution of the class
(i.e., no objects were created). So you could say that program doesn't
do anything, yet obviously something must have happened since code was
processed.*

Surprisingly, the fix can be either:
```ruby
module Maintenance
  def change_tires
    "Changing #{Vehicle::WHEELS} tires."    # this fix works
  end
end
```
or
```ruby
module Maintenance
  def change_tires
    "Changing #{Car::WHEELS} tires."        # surprisingly, this also works
  end
end
```
The reason Car::WHEELS works is because we're telling Ruby to look for
WHEELS in the Car class, which can access Vehicle::WHEELS through
inheritance.

Constant resolution will look at the lexical scope first, and then look
at the inheritance hierarchy. It can get very tricky when there are
nested modules, each setting the same constants to different values.
Be mindful that constant resolution rules are different from method
lookup path or instance variables.

## Summary

- Instance Variables behave the way we'd expect. The only thing to
  watch out for is to make sure the instance variable is initialized
  before referencing it.
- Class Variables have a very insidious behavior of allowing sub-classe
  to override super-class class variables. Further, the change will
  affect all other sub-classes of the super-class. This is extremely
  unintuitive behavior, forcing some Rubyists to eschew using class
  variables altogether.
- Constants have lexical scope which makes their scope resolution rules
  very unique compared to other variable types. If Ruby doesn't find the
  constant using lexical scope, it'll then look at the inheritance
  hierarchy.

If you ever run into a situation where you forget these rules, just hop in irb and experiment until you remember again. You won't remember these rules the first or even the tenth time reading about them. Don't be afraid to experiment with various scenarios.
Variable Scope

