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

Side note: Float and Bignum are the other kinds of numbers. Float
is used for floating point precision numbers. Bignum is not used
very often except when you need very large numbers.

So when should we write a + method for our own objects? Let's look
at the standard library for some inspiration:

- Fixnum#+: increments the value by value of the argument,
  returning a new integer
- String#+: concatenates with argument, returning a new string
- Array#+: concatenates with argument, returning a new array
- Date#+: increments the date in days by value of the argument,
  returning a new date

Do you see a pattern? **The functionality of the + should be either
incrementing or concatenation with the argument.** You are, of
course, free to implement it however you wish, but it's probably
a good idea to follow the general usage of the standard libraries.
Here's an example:
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

  def +(other_team)
    members + other_team.members
  end
end

# we'll use the same Person class from earlier

cowboys = Team.new("Dallas Cowboys")
cowboys << Person.new("Troy Aikman", 48)
cowboys << Person.new("Emmitt Smith", 46)
cowboys << Person.new("Michael Irvin", 49)

niners = Team.new("San Francisco 49ers")
niners << Person.new("Joe Montana", 59)
niners << Person.new("Jerry Rice", 52)
niners << Person.new("Deion Sanders", 47)
```
Study the code above -- it's all our set up code. We haven't
actually used the Team#+ method yet. All we've done so far is
take a shot at implementing it, then created some objects in
preparation to use it. Now the question is: how do we use the
Team#+ method we just wrote?

Let's take a shot.
```ruby
dream_team = cowboys + niners               # what is dream_team?
```
Remember that cowboys + niners is the same as cowboys.+(niners),
so in order to understand what that expression returns, we have to
study Team#+. If we look at the implementation, we can see that
it returns a new Array object. Therefore, dream_team from the
above example is an array of Person objects.

Now, that may be what you meant to implement, and from a pure
technical standpoint, that is perfectly valid. But does that match
the general pattern we saw from the standard library? No, it
doesn't. The Fixnum#+ method returns a new Fixnum object; the
String#+ method returns a new String object; the Date#+ method
returns a new Date object.

Our Team#+ method should return a new Team object. The
Team#initialize method, however, requires a name, which makes it
a little awkward. We could do more refactoring to improve it,
but that will deviate too much from the main point of this section.
We'll just initialize the team name to "Temporary Team" for now.
```ruby
class Team
  # ... rest of class omitted for brevity

  def +(other_team)
    temp_team = Team.new("Temporary Team")
    temp_team.members = members + other_team.members
    temp_team
  end
end
```
Now, dream_team is no longer an array, but a Team object, which
is what we'd expect when we use Team#+.

# Element setter and getter methods

At this point, you've likely used element setter and getter
methods a lot already, probably mostly by way of working with
arrays. Out of all the fake operators, perhaps `[]` and `[]=` are
the most surprising. Part of the reason is because the syntactical
sugar given to these two methods is so extreme. For example:
```ruby
my_array = %w(first second third fourth) # ["first", "second", "third", "fourth"]

# element reference
my_array[2]                                 # => "third"
my_array.[](2)                              # => "third"
```
The above two examples of using `Array#[]` to reference an element
are identical, yet they look dramatically different. How did the
2 get in between the square brackets? That's Ruby giving us a nice
syntax.

But Ruby goes even one step farther for `Array#[]=`.
```ruby
# element assignment
my_array[4] = "fifth"
puts my_array.inspect   # => ["first", "second", "third", "fourth",
                        #     "fifth"]

my_array.[]=(5, "sixth")
puts my_array.inspect   # => ["first", "second", "third", "fourth",
                        #     "fifth", "sixth"]
```
I think we can agree that the my_array[4] = "fifth" syntax reads
much more naturally, but this syntax manipulation is also why
sometimes it's hard to understand where certain code comes from.

If we want to use the element setter and getter methods in our
class, we first have to make sure we're working with a class that
represents a collection. Again, these are normal instance methods
, so we can make them do anything. But let's follow the lead of
the Ruby standard library, and build them as simple getter
(reference) and setter (assignment) methods for elements in our
collection.

```ruby
class Team
  # ... rest of code omitted for brevity

  def [](idx)
    members[idx]
  end

  def []=(idx, obj)
    members[idx] = obj
  end
end
```
Here, we're just taking advantage of the fact that @members is
an array, so we can push the real work to the Array#[] and
Array#[]= methods. After writing these two methods, we can:
```ruby
# assume set up from earlier
cowboys.members                # => ... array of 3 Person objects

cowboys[1]                     # => #<Person:0x007fae9295d830
                               #    @name="Emmitt Smith", @age=46>
cowboys[3] = Person.new("JJ", 72)
cowboys[3]                     # => #<Person:0x007fae9220fa88
                               #      @name="JJ", @age=72>
```
Notice that we can now do both element reference and assignment
using Team#[] and Team#[]=, respectively. This syntactical sugar
adds a new readability aspect to our code.

## Summary

In this assignment, we saw how many operators are in fact methods
that Ruby gives special treatment to. Because they are methods,
we can implement them in our classes and take advantage of the
special syntax for our own objects. If we do that, we must be
careful to follow conventions established in the Ruby standard
library. Otherwise, using those methods will be very confusing.

The most important thing for now is being able to read Ruby code.
Learning how to write your own fake operators will take more time,
but the goal right now is to alleviate confusion about why you
see certain syntax, but can't understand what's happening.
Hopefully this assignment shed some light on that.