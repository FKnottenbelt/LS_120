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

# Encapsulation
`Encapsulation` is hiding pieces of functionality and making it
unavailable to the rest of the code base. It is a form of data
protection, so that data cannot be manipulated or changed
without obvious intention. It is what defines the boundaries
in your application and allows your code to achieve new levels
of complexity. Ruby, like many other OO languages,
accomplishes this task by creating objects, and exposing
interfaces (i.e., methods) to interact with those objects.

# objects
Defining a class lets you group behaviors (methods) into
convenient bundles, so that you can quickly create many
objects that behave essentially the same way. You can also
add methods to individual objects, if that’s appropriate for
what you’re trying to do in your program. But you don’t have
to do that with every object if you model your domain into
classes.

# classes
A typical class consists of a collection of method definitions.
Classes usually exist for the purpose of being instantiated—
that is, of having objects created that are instances of the
class.

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
