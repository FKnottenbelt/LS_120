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

# Polymorphism
is the ability for data to be represented as many different types.
"Poly" stands for "many" and "morph" stands for "forms". OOP
gives us flexibility in using pre-written code for new purposes.
- overide methods
- inheritance
- module mixins (behavior sharing)

The polymorphism is the process of using an operator or
function in different ways for different data input.


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