# Fake Operators

One reason Ruby is hard for beginners is due to its liberal syntax. We've
already seen from the Equivalence assignment that the "double equals"
equality operator, ==, is actually a method and not a real operator. It
only looks like an operator because Ruby gives us special syntactical sugar
when invoking that method. Instead of calling the method normally
(eg. str1.==(str2)), we can call it with a special syntax that reads more
naturally (eg. str1 == str2).

This might have triggered the question: what other operators are actually
methods being invoked with special syntax? Are all operators, in fact,
methods? Below is a table that shows which operators are real operators,
and which are methods disguised as operators (listed by order of precedence;
highest first).

 | Method | Operator                                                                              | Description                                                                         |
|--------|---------------------------------------------------------------------------------------|-------------------------------------------------------------------------------------|
| yes    | `[]`, `[]=`                                                                           | Collection element getter and setter.                                               |
| yes    | `**`                                                                                  | Exponential operator                                                                |
| yes    | `!`, `~`, `+`, `-`                                                                    | Not, complement, unary plus and minus (method names for the last two are +@ and -@) |
| yes    | `*`, `/`, `%`                                                                         | Multiply, divide, and modulo                                                        |
| yes    | `+`, `-`                                                                              | Plus, minus                                                                         |
| yes    | `>>`, `<<`                                                                            | Right and left shift                                                                |
| yes    | `&`                                                                                   | Bitwise "and"                                                                       |
| yes    | `^`,`|`                                                                 | Bitwise exclusive "or" and regular "or" (inclusive "or")                                          |
| yes    | `<=`, `<`, `>`, `>=`                                                                  | Less than/equal to, less than, greater than, greater than/equal to                  |
| yes    | `<=>`, `==`, `===`, `!=`, `=~`, `!~`                                                  | Equality and pattern matching (`!=` and `!~` cannot be directly defined)            |
| no     | `&&`                                                                                  | Logical "and"                                                                       |
| no     | `||`                                                                                  | Logical "or"                                                                        |
| no     | `..`, `...`                                                                           | Inclusive range, exclusive range                                                    |
| no     | `? :`                                                                                 | Ternary if-then-else                                                                |
| no     | `=`, `%=`, `/=`, `-=`, `+=`, `|=`, `&=`, `>>=`, `<<=`, `*=`, `&&=`, `||=`, `**=`, `{` | Assignment (and shortcuts) and block delimiter                                      |

The operators marked with a "yes" in the "Method" column means that
these operators are in fact methods, which means we can override their
functionality. This appears to be a useful feature, but the other side
is that since any class can override these fake operators, reading
code like this: obj1 + obj2 opens up a world of possibility as to
what that can mean. Notice that except assignment and a few other
obvious operators, there appears to be a lot of fake operators that
we can override! This makes Ruby both powerful and potentially
dangerous. Let's explore how to use these fake operators in a sensible
way.

# Equality methods

One of the most common fake operators to be overridden is the `==`
equality operator. Since we spent a good amount of time talking about
that already, we won't cover it in depth here. Suffice it to say it's
very useful to override this method, and doing so also gives us
a `!=` method.

# Comparison methods

Overriding the comparison methods gives us a really nice syntax
for comparing objects. Take, for example, the following class.
```ruby
class Person
  attr_accessor :name, :age

  def initialize(name, age)
    @name = name
    @age = age
  end
end
```
We could then instantiate a few Person objects.
```
bob = Person.new("Bob", 49)
kim = Person.new("Kim", 33)
```
What happens if we try to compare them?
```
puts "bob is older than kim" if bob > kim
```

If we run that code, we get a NoMethodError. Ruby can't find the
`>` method for bob. Let's fix that by adding a > method to the Person
class.

```ruby
class Person
  # ... rest of code omitted for brevity

  def >(other_person)
    age > other_person.age
  end
end
```

The above implementation will return true if the current object's
age is greater than the other_person's age, and false otherwise.
Notice that we are pushing the comparison functionality to the
Fixnum#> method. Now, we can use the Person#> method in conditionals.

```
puts "bob is older" if bob > kim            # => "bob is older"
puts "bob is older" if bob.>(kim)           # => "bob is older"
```

Note that defining `>` doesn't automatically give us `<`. If we were
to write `bob < kim`, we'd get a NoMethodError.

# The << and >> shift methods

By now, you've likely already encountered the << method when
working with arrays. It's pretty standard to write the following:
```ruby
my_array = %w(hello world)
my_array << "!!"
puts my_array.inspect               # => ["hello", "world", "!!"]
```

Up to now, you may have thought that the << was a standard Ruby
operator, but in fact, the my_array << "!!" was calling the Array#<<
method. This is why we can't do the same for hashes, because Hash
doesn't contain a << method.

```ruby
my_hash = {a: 1, b: 2, c: 3}
my_hash << {d: 4}   # => NoMethodError: undefined method `<<' for Hash
```

You may have seen such an error message before, but dismissed it.
Read the error message carefully: NoMethodError: undefined method
'<<'. This should give you a hint that << was actually a method
disguised as an operator.

Just like any of the other fake operators, you can override << or >>
to do anything; they are, after all, just regular instance methods.
However, it's not common to override >>, so we won't go into detail
explaining it in this assignment.

When overriding fake operators, choose some functionality that makes
sense when used with the special operator-like syntax. For example,
using the << method fits well when working with a class that
represents a collection.
```ruby
class Team
  attr_accessor :name, :members

  def initialize(name)
    @name = name
    @members = []
  end

  def <<(person)
    members.push person
  end
end

cowboys = Team.new("Dallas Cowboys")
emmitt = Person.new("Emmitt Smith", 46)   # suppose we're using the
                                          # Person class from earlier

cowboys << emmitt                          # will this work?

cowboys.members                     # => [#<Person:0x007fe08c209530>]
```
By implementing a Team#<< method, we provided a very clean interface
for adding new members to a team object. If we wanted to be strict,
we could even build in a guard clause to reject adding the member
unless some criteria is met
```ruby
def <<(person)
  return if person.not_yet_18?    # suppose we had Person#not_yet_18?
  members.push person
end
```
Adding the shift operators can result in very clean code, but they
make the most sense when working with classes that represent a
collection.

# The plus method

One of the first examples you'll see in any introduction to
programming tutorial is: 1 + 1 == 2. But even this simple line of
code has hidden depth. We're finally able to reveal the hidden
secret: that's actually a method call.
```
1 + 1                                       # => 2
1.+(1)                                      # => 2
```

For this reason, Rubyists keep repeating the phrase everything in
Ruby is an object, and that's true for integers as well. Because
integers are objects of the Fixnum class, they have access to the
Fixnum instance methods. In the case of 1.+(1), the method we're
using is Fixnum#+. In ruby, a Fixnum is a specific kind of integer.

