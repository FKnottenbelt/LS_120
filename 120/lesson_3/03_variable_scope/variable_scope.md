# Variable Scope

When we talked about variable scoping rules in the past, we always talked about
local variables. In this assignment, we'll talk about variable scoping rules for
instance and class variables and constants. We'll also talk about how
inheritance affects these variable scoping rules.


## Instance Variable Scope
Instance variables are variables that start with `@ `and are scoped at the
object level. They are used to track individual object state, and do not cross
over between objects. For example, we can use a @name variable to separate the
state of Person objects.
```ruby
class Person
  def initialize(n)
    @name = n
  end
end

bob = Person.new('bob')
joe = Person.new('joe')

puts bob.inspect              # => #<Person:0x007f9c830e5f70 @name="bob">
puts joe.inspect              # => #<Person:0x007f9c830e5f20 @name="joe">
```
Because the scope of instance variables is at the object level, this means that
the instance variable is accessible in an object's instance methods, even if
it's initialized outside of that instance method.

```ruby
class Person
  def initialize(n)
    @name = n
  end

  def get_name
    @name                     # is the @name ivar accessible here?
  end
end

bob = Person.new('bob')
bob.get_name                  # => "bob"
```

Unlike local variables, instance variables are accessible within an instance
method even if they are not initialized or passed in to the method. Remember,
their scope is at the object level.

What if we try to access an instance variable that is not yet initialized
anywhere?

```ruby
class Person
  def get_name
    @name                     # the @name ivar is not initialized anywhere
  end
end

bob = Person.new
bob.get_name                  # => nil
```

This shows another distinction from local variables. If you try to reference an
uninitialized local variable, you'd get a NameError. But if you try to reference
an uninitialized instance variable, you get nil.

Sidenote: what happens if you accidentally put an instance variable at the class
level?

```ruby
class Person
  @name = "bob"              # class level initialization

  def get_name
    @name
  end
end

bob = Person.new
bob.get_name                  # => nil
```

The short answer is: don't do that for now. The long answer is that instance
variables initialized at the class level are an entirely different thing called
**class instance variables**. You shouldn't worry about that yet, but just
remember to initialize instance variables within instance methods.

## Class Variable Scope

Class variables start with `@@` and are scoped at the class level. They exhibit
two main behaviors:

- all objects share 1 copy of the class variable. (This also implies objects
  can access class variables by way of instance methods.)
- class methods can access class variables, regardless of where it's
  initialized.

Let's see an example.
```ruby
class Person
  @@total_people = 0            # initialized at the class level

  def self.total_people
    @@total_people              # accessible from class method
  end

  def initialize
    @@total_people += 1         # mutable from instance method
  end

  def total_people
    @@total_people              # accessible from instance method
  end
end

Person.total_people             # => 0
Person.new
Person.new
Person.total_people             # => 2

bob = Person.new
bob.total_people                # => 3

joe = Person.new
joe.total_people                # => 4

Person.total_people             # => 4
```

From the above, you can see that even when we have two different Person objects
in bob and joe, we're effectively accessing and modifying one copy of the
@@total_people class variable. We can't do this with instance variables or
local variables; only class variables can share state between objects. (We're
going to ignore globals.)

## Constant Variable Scope

Constant variables are usually just called constants, because you're not
supposed to re-assign them to a different value. If you do re-assign a constant,
Ruby will warn you (but won't generate an error). Constants begin with a capital
letter and have lexical scope. Let's play around with constant scope.

```ruby
class Person
  TITLES = ['Mr', 'Mrs', 'Ms', 'Dr']

  attr_reader :name

  def self.titles
    TITLES.join(', ')
  end

  def initialize(n)
    @name = "#{TITLES.sample} #{n}"
  end
end

Person.titles                   # => "Mr, Mrs, Ms, Dr"

bob = Person.new('bob')
bob.name                        # => "Ms bob"  (output may vary)
```

As you can see from the example above, within one class, the rules for accessing
constants is pretty easy: it's available in class methods or instance methods
(which implies it's accessible from objects). Where constant resolution gets
really tricky is when inheritance is involved, and that's when we need to
remember that unlike other variables, constants have **lexical scope**.
