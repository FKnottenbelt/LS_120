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