# Benefits of using Object Oriented Programming

Creating objects allows programmers to think more abstractly about the
code they are writing.

Objects are represented by nouns so are easier to conceptualize.

It allows us to only expose functionality to the parts of code that
need it, meaning namespace issues are much harder to come across.

It allows us to easily give functionality to different parts of an
application without duplication.

We can build applications faster as we can reuse pre-written code.

As the software becomes more complex this complexity can be more
easily managed.


# 4 basic OOP programming concepts
- Abstraction
- Polymorphism
- Encapsulation
- Inheritance

The abstraction is simplifying complex reality by modeling
classes appropriate to the problem.

The polymorphism is the process of using an operator or
function in different ways for different data input.

The encapsulation hides the implementation details of a class
from other objects.

The inheritance is a way to form new classes using classes
that have already been defined.

# Polymorphism
`Polymorphism` is the ability for data to be represented as many
different types. "Poly" stands for "many" and "morph" stands for
"forms". OOP gives us flexibility in using pre-written code for new
purposes.
- overide methods
- inheritance
- module mixins (behavior sharing)

The polymorphism is the process of using an operator or
function in different ways for different data input.

```ruby
class Animal
  def speak
    puts "I can speak"
  end
end

class Wolf < Animal
  def hunt
    puts "I'm a predator"
  end
end

class Deer < Animal
  def hunt
    puts "I'm prey"
  end
end

wolfie = Wolf.new
bambi = Deer.new
wolfie.speak
wolfie.hunt
bambi.speak
bambi.hunt
```

# Encapsulation
`Encapsulation` is hiding pieces of functionality and making it
unavailable to the rest of the code base. It is a form of data
protection, so that data cannot be manipulated or changed
without obvious intention. It is what defines the boundaries
in your application and allows your code to achieve new levels
of complexity. Ruby, like many other OO languages,
accomplishes this task by creating objects, and exposing
interfaces (i.e., methods) to interact with those objects.

# Inheritance
The inheritance is a way to form new classes using classes
that have already been defined.
This way we can reuse common code and still have specialiced code
for our subclasses. And our subclasses can override superclass code
if needed

```ruby
class Animal
  def speak
    puts "I can speak"
  end
end

class Wolf < Animal
  def hunt
    puts "I'm a predator"
  end
end

class Deer < Animal
  def hunt
    puts "I'm prey"
  end
end

wolfie = Wolf.new
bambi = Deer.new
wolfie.speak
wolfie.hunt
bambi.speak
bambi.hunt
```

# classes
A typical class consists of a collection of method definitions.
Classes usually exist for the purpose of being instantiated—
that is, of having objects created that are instances of the
class.

# objects
Defining a class lets you group behaviors (methods) into
convenient bundles, so that you can quickly create many
objects that behave essentially the same way. You can also
add methods to individual objects, if that’s appropriate for
what you’re trying to do in your program. But you don’t have
to do that with every object if you model your domain into
classes.

```ruby
class Cat
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def hunt
    puts "getting mouse!"
  end
end

stripe = Cat.new('Stripe')
black = Cat.new('Black')
stripe.hunt
black.hunt
```
# constructors
A constructor is a special kind of a method. It is automatically
called when an object is created. Constructors do not return
values. The purpose of the constructor is to initiate the state
of an object. The constructor in Ruby is called initialize.
Constructors do not return any values.

# module
Like classes, modules are bundles of methods and constants.

Unlike classes, modules don’t have instances; instead, you
specify that you want to add the functionality of a particular
module to that of a class or of a specific object.

A module is a collection of behaviors that is useable in other
classes via mixins. A module is "mixed in" to a class using
the include method invocation.

```ruby
module Swimmable
  def swim
    puts "I, the #{self.class}, can swim!"
  end
end

class Cat
  include Swimmable
end

class Dog
  include Swimmable
end

kitty = Cat.new
kitty.swim
dog = Dog.new
dog.swim
```

You can also use modules for namespacing. That is to use modules to
group related classes.

```ruby
module Mammal
  class Dog
    def speak(sound)
      # your code here
    end
  end

  class Cat
    def say_name(name)
      # your code here
    end
  end
end
```
Benefits:
- easy to recognize related classes
- reduces the likelihood of our classes colliding with other
  similarly named classes in our codebase.

```ruby
module Tools
  class Hammer
    puts "Use me to do things like hammer in nails"
  end
end

module Piano
  class Hammer
    puts "Use me to make music"
  end
end

# use namespace resolution operator to call.
Tools::Hammer
Piano::Hammer
```

Also use modules for containers of methods. Very useful for
methods that seem out of place within your code.
```ruby
module HandyMethods
  def self.clear_screen
    system("cls") || system("clear")
  end

  def joiner(arr, delimiter=', ', word='or')
    array = arr.dup
    array << array.pop(2).join(' ' + word + ' ')
    array.join(delimiter)
  end
end

class Game
  include HandyMethods

  def give_choice(choices)
    joiner(choices)
  end
end

action = HandyMethods.clear_screen
game = Game.new
p game.give_choice([1,2,3])
```

# Inheritance and modules
Ruby implements inheritance via class inheritance and mixing in
modules.

- You can only subclass from one class. But you can mix in as many
  modules as you'd like.
- If it's an `is-a` relationship, choose class inheritance.
- If it's a `has-a` relationship, choose modules. Example: a dog
  "is an" animal; a dog "has an" ability to swim.
- You cannot instantiate modules (i.e., no object can be created
  from a module). Modules are used only for namespacing and grouping
  common methods together.

```ruby
module Swimmable
  def swim
    puts "#{self.class.name} can swim"
  end
end

class Mammal
  def initialize(name)
    @name = name
  end

  def pregancy
    puts "Our females grow our babies in their belly"
  end
end

class Dog < Mammal
  include Swimmable

  def hunt
    puts "I can hunt"
  end
end

class Fish
  include Swimmable

  def initialize(name)
    @name = name
  end

  def lay_eggs
    puts "We grow our babies in the eggs we lay"
  end
end

fido = Dog.new("Fido")
nemo = Fish.new("Nemo")
fido.swim
nemo.swim
fido.pregancy
nemo.lay_eggs

# Dog can swim
# Fish can swim
# Our females grow our babies in their belly
# We grow our babies in the eggs we lay
```

# instance method
Methods of this kind, defined inside a class and intended for
use by all instances of the class, are called instance methods.
They don’t belong only to one object. Instead, any instance of
the class can call them.

# attribute
An attribute is a property of an object whose value can be
read and/or written through the object. In the case of ticket
objects, we’d say that each ticket has a price attribute as
well as a date attribute and a venue attribute. Our price=
method can be described as an attribute writer method. date,
venue, and price (without the equal sign) are attribute reader
methods. (The write/read terminology is equivalent to the
set/get terminology used earlier, but write/read is more
common in Ruby discussions.)

The attributes of Ruby objects are implemented as reader
and/or writer methods wrapped around instance variables—or,
if you prefer, instance variables wrapped up in reader and/or
writer methods. There’s no separate “attribute” construct at
the language level. Attribute is a high-level term for a
particular configuration of methods and instance variables.
But it’s a useful term, and Ruby does embed the concept of
attributes in the language, in the form of shortcuts that
help you write the methods that implement them.

class variables: 03_04
instance variables: 03_04

# getters and setters
getter and setter methods are methods that expose attributes to
other objects. Getters lets you read them, setters lets you change
the attribute.
You can write them in long form. For example here is a getter for
name:
```ruby
def name
  @name
end
```
The long form is usefull if for example you want to show a modified
version of your instance variable to other objects:
```ruby
def name
  "Honarable " + @name
end
```

You can use accessor methods (the short form so to say)
```ruby
attr_reader :name     # short for get_name plus @name
attr_writer :name     # short for set_name us @name
attr_accessor :name   # short for get_name & set_name plus @name
```
Getters and setters in action:
```ruby
class GoodDog
  attr_reader :name     # short for get_name plus @name
  attr_writer :name     # short for set_name us @name
  attr_accessor :name   # short for get_name & set_name plus @name
  def initialize(name)
    @name = name
  end

  def name  # short for get_name
    @name
  end

  def name=(name) # short for set_name
    @name = name
  end

  def speak
    "#{name} says arf!"
  end
end

sparky = GoodDog.new("Sparky")
puts sparky.speak
puts sparky.name
sparky.name = "Spartacus"
puts sparky.name
```

NB: setters need self

# method lookup path
The method lookup path is the order in which Ruby will traverse the
class hierarchy to look for methods to invoke.
To see the method lookup path, we can use the .ancestors class method.
So call on Class! (not object)
```ruby
class Pet ; end
class Dog < Pet ; end
class Bulldog < Dog ;end
p Bulldog.ancestors  # => [Bulldog, Dog, Pet, Object, Kernel, BasicObject]
```
Note that this method returns an array, and that all classes
sub-class from Object.

# States an behaviors
`States` track attributes for individual objects. Instance variables (the
attributes) keep track of states (values of the attributes). State is
unique for each object.

`Behaviours` are what objects are capable of doing. Instance methods expose
behaviour for objects. Behaviour is common for all objects of a class.

```ruby
class Cat
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def hunt
    puts "getting mouse!"
  end
end

stripe = Cat.new('Stripe')
black = Cat.new('Black')
stripe.hunt     # common behavior
black.hunt      # common behavior
p stripe.name   # unique state
p black.name    # unique state
```

# exception
Exceptions are objects that signal deviations from the normal
flow of program execution. Exceptions are raised, thrown or
initiated.

Exceptions are objects. They are descendants of a built-in
Exception class. Exception objects carry information about
the exception. Its type (the exception’s class name), an
optional descriptive string, and optional traceback
information. Programs may subclass Exception, or more often
StandardError, to obtain custom Exception objects that provide
additional information about operational anomalies.

# self
the current or default object

self inside a class or module definition?: the class or
module object
```ruby
 class Cat
    @@cat_count = 0   # Class variable
    attr_accessor :name

    def initialize(name)
      @@cat_count += 1
      @name = name
    end

    def count       # instance method, call from object
      @@cat_count
    end

    def self.count  # Class method, call from Class
      @@cat_count
    end

    def change_name(new_name)
      self.name = new_name
    end
  end

p Cat.count   # calling self.count
cat = Cat.new('Kitty')
p cat.count   # callin count
cat.name=("fluffy")
cat.change_name("spiky")
p cat.name
```

# collaborator objects
Objects that are stored as state within another object are
also called "collaborator objects".
```ruby
class Library
  attr_accessor :books
  def initialize
    @books = []
  end

  def add_book(new_book)
    books << new_book
  end

  def list_books
    puts "Books in the library:"
    books.each do |book|
      puts book
    end
  end
end

class Book
  attr_reader :title, :author

  def initialize(title, author)
    @title = title
    @author = author
  end

  def to_s
    "#{title} by #{author}"
  end
end

lib = Library.new
book1 = Book.new("A fresh new day", "John Johnson")
book2 = Book.new("Time Management", "Kerel Janssen")
lib.add_book(book1)
lib.add_book(book2)
lib.list_books
```
# Reading OO code
```ruby
class Dog
  def initialize(name)
    @name = name
  end

  def say_hello
    puts "Woof! My name is #{@name}."
  end
end
```
"This code defines a `Dog` class
with two methods:

- The `#initialize` method that initializes a new Dog object,
  which it does by assigning the instance variable `@name` to
  the dog's name specified by the argument.(parameter?!?)
- The `#say_hello` instance method which prints a message that
  includes the dog's name in place of `#{@name}`. `#say_hello`
  returns `nil`."

# super
super is a method that will search the method lookup path for a
method with the same name and then invoke it.
```ruby
class Animal
  attr_accessor :name

  def initialize(name)
    @name = name
    @location = 'Earth'
  end
end

class GoodDog < Animal
  def initialize(name, color)
    super(name)
    @color = color
  end
end

bruno = GoodDog.new('Bruno','brown')
p bruno
#<GoodDog:0x00000000f4d210 @name="Bruno", @location="Earth",
# @color="brown">

```
# Private, Protected, Public
Access for methods can be restricted by public, private or protected
methods.

A `public method` is a method that is available to anyone who knows
either the class name or the object's name.
Default Ruby methods are public.

A `private method` is a methods that is doing work in the class but
doesn't need to be available to the rest of the program.
You can only access it from within the class. Not straight from instances
of the class.

NB: you can't have anything 'before the dot' when calling a private method.
Or in official speak: a private method can never be called with an
explicit receiver.
So: no self.
(we CAN call a private method from within a class it is declared in as
well as all subclasses of this class e.g.)

```ruby
class Animal
  def initialize(name)
    @name = name
  end

  def get_name
    name
  end

  private
  attr_reader :name
end

cat = Animal.new('kitty')
p cat.get_name
p cat.name # <private method `name' called for #<Animal:0x00000001e4b898
# @name="kitty"> (NoMethodError)
```

A `protected` method
From outside the class, protected methods act just like private
methods. From inside the class, protected methods are accessible just like
public methods.
Most often used to compare values of two different instances with another.
(when we don't want things to be public, because that obviously will always
work)

Any instance of a class can call a protected method on another
instance of the class.

```ruby
class Person
  attr_writer :age

  def older_than?(other)
    age > other.age
  end

  protected
  attr_reader :age
end

person1 = Person.new
person1.age = 17

person2 = Person.new
person2.age = 26

puts person1.older_than?(person2)
```
When a method is private, only the class - not instances of the class
- can access it. However, when a method is protected, only instances of
the class or a subclass can call the method. This means we can easily
share sensitive data between instances of the same class type.

Here we compares the ages of two people. The getter method is protected,
though, which means we can only access it from another instance of the
same class. Therefore, we have to invoke older_than? on an existing
instance, and pass in another instance as an argument. We can then
compare the two ages to determine who is older.

# Constants (03_04)
Constants are defined with uppercase letters.
They contain variables that are not meant to change.

Unlike instance methods or instance variables, constants are not
evaluated at runtime, so their lexical scope - or, where they are
used in the code - is very important.
Constants have lexical scope
Constant resolution will look at the lexical scope first, and then
look at the inheritance hierarchy.

```ruby
module Maintenance
  def change_tires
    "Changing #{self.class::WHEELS} tires."
  end
end

class Vehicle
  WHEELS = 4
end

class Car < Vehicle
  include Maintenance
end

class Truck < Vehicle
  include Maintenance
end

a_car = Car.new
p a_car.change_tires
a_truck = Truck.new
p a_truck.change_tires
```

# Fake operators (03_05)
`Fake operators` are not really operators, but methods we can override.

```ruby
class Cat
  attr_reader :age

  def initialize(name, age)
    @name = name
    @age = age
  end

  def ==(other)  # overriding BasicObject#==
    age == other.age
  end
end

fluffy = Cat.new('fluffy', 6)
kitty = Cat.new('kitty', 6)
p fluffy == kitty  # now comparing age instead of object-id
str1 = "hello"
str2 = "hello"
p str1 == str2 # String#== overrides BasicObject#== to compare values

p fluffy.equal?(kitty)  # false: not same object
```

# Truthiness (03_01)
true -> TrueClass
false -> FalseClass
true or false are not nil
false.to_s => 'false'
```
true.class          # => TrueClass
true.nil?           # => false
true.to_s           # => "true"
true.methods        # => list of methods you can call on the true object

false.class         # => FalseClass
false.nil?          # => false
false.to_s          # => "false"
false.methods       # => list of methods you can call on the false object
```
see 109..
`short circuiting`: will stop evaluating expressions once it can
guarantee the return value.


# Equality (03_02)
```
str1 = "something"
str2 = "something"
str1 == str2            # => true

int1 = 1
int2 = 1
int1 == int2            # => true

sym1 = :something
sym2 = :something
sym1 == sym2            # => true
```
the == method compares the two variables' values whereas
the equal? method determines whether the two variables point to the
same object.

```ruby
class Cat
  attr_reader :age

  def initialize(name, age)
    @name = name
    @age = age
  end

  def ==(other)  # overriding BasicObject#==
    age == other.age
  end
end

fluffy = Cat.new('fluffy', 6)
kitty = Cat.new('kitty', 6)
p fluffy == kitty  # now comparing age instead of object-id
str1 = "hello"
str2 = "hello"
p str1 == str2 # String#== overrides BasicObject#== to compare values

p fluffy.equal?(kitty)  # false: not same object
```