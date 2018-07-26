# Equivalence

Though a seemingly simple idea, testing for equivalence in Ruby is
actually very complicated. Before we learned about Object Oriented
programming and before we understood that everything is an object,
the idea of equivalence was very simple. A string is equal to another
string of the same value. An integer is equal to another integer of
the same value. A symbol is equal to another symbol of the same value.
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
Nothing unusual here. Things get more muddy, however, when you consider
that everything is an object. When we're doing the == equality comparison
above, what exactly are we comparing?

Consider that a string literal is just an object of the String class.
```
str1 = "something"
str2 = "something"

str1.class              # => String
str2.class              # => String
```
This means that if we modify str1, it would have no effect on the
str2 object; they are different objects.
```
str1 = str1 + " else"
str1                    # => "something else"

str1 == str2            # => false
```
So when we compare str1 with str2 using ==, the string objects
somehow know to compare their values, even though they're different
objects. What we're asking is "are the values within the two objects
the same?" and not "are the two objects the same?".

In the case of String objects, it knows we're asking the first
question and not the second. But what if we wanted to ask the second
question? Suppose we care about whether the two variables actually
point to the same object? That's where another method comes in:
the `equal? method`.
```
str1 = "something"
str2 = "something"
str1_copy = str1
```
# comparing the string objects' values
```
str1 == str2            # => true
str1 == str1_copy       # => true
str2 == str1_copy       # => true
```
# comparing the actual objects
```
str1.equal? str2        # => false
str1.equal? str1_copy   # => true
str2.equal? str1_copy   # => false
```

Notice that when we use == to compare the string object values,
everything is true; all 3 variables have the value "something".
However, the story changes when we use the equal? method. Because
the equal? method checks to see if the two objects are the same,
only `str1.equal? str1_copy` returns true. This is because str1 and
str1_copy reference the same object, or space in memory.

Sidenote: Now may be a good time to revisit the Variables as
Pointers section.

In summary, the == method compares the two variables' values whereas
the equal? method determines whether the two variables point to the
same object. This begs the question: how does == know which value to
use to compare? In the case of String objects, it may be simple, but
what if we were comparing Array objects? In that case, should == use
the array's size? Or all the elements in the array? What if we're
comparing a custom object from a class we wrote? How will == determine
the object's value in that case?

## The == method

The answer is that == is not an operator in Ruby, like the = assignment
operator. Instead, it's actually an instance method available on all
objects. Ruby gives the == method a special syntax to make it look
like a normal operator. For example, instead of calling the method as
str1.==(str2), we can use the more natural syntax str1 == str2. Both
options are functionally equivalent. This syntactical sugar is a double
edge sword: it allows us to write more naturally, but makes deciphering
code more difficult for beginners.

Since it's an instance method, the answer to "how does == know what
value to use for comparison" is: it's determined by the class.

The original == method is defined in the BasicObject class, which is
the parent class for all classes in Ruby. This implies every object
in Ruby has a == method. However, each class should override the ==
method to specify the value to compare.

For example, suppose we have a Person class:
```ruby
class Person
  attr_accessor :name
end

bob = Person.new
bob.name = "bob"

bob2 = Person.new
bob2.name = "bob"

bob == bob2                # => false

bob_copy = bob
bob == bob_copy            # => true
```
This implies that the default implementation for == is the same
as equal? (which is also in the BasicObject class). It's not very
useful, because when we use ==, we don't actually want to ask "are
the two variables pointing to the same object?", and instead, we want
to ask "are the values in the two variables the same?". To tell Ruby
what "the same" means for a Person object, we need to override the
== method.

```ruby
class Person
  attr_accessor :name

  def ==(other)
    name == other.name     # relying on String#== here
  end
end

bob = Person.new
bob.name = "bob"

bob2 = Person.new
bob2.name = "bob"

bob == bob2                # => true
```
By defining a == method in our Person class, we're overriding the
default BasicObject#== behavior, and providing a much more meaningful
way to compare two Person objects. Incidentally, you can do this
with < and > as well, as those are also instance methods, and not
built-in Ruby operators. We'll cover this topic in more detail later.

Note that the Person#== method we just wrote uses the String#== method
for comparison. That's perfectly ok, and almost every Ruby core
library class will come with its own == method. Therefore, you can
safely use == to compare Array, Hash, Fixnum, String and many other
objects. But just remember there's a method somewhere backing that
equality comparison, and so it can be modified.

Now that you understand == is just a method, this code makes more sense:
```
45 == 45.00                 # => true
```

The above code is actually 45.==(45.00), which means that it's calling
the Fixnum#== method. You can imagine that the implementer of this
method took care to consider the possibility of comparing an integer
with a float, and handled the conversion from float to integer
appropriately.

This is the first time we've seen comparing two objects of different
classes. But this is possible because you can implement == however
you wish. You should also realize that 45 == 45.00 is not the same as
45.00 == 45. The former is calling Fixnum#== while the latter is
calling Float#==. Thankfully, the creator of those methods took time
to make the interface consistent.

One final note: when you define a == method, you also get the != for
free.

## object_id

Every object has a method called object_id, which returns a numerical
value that uniquely identifies the object. We can use this method to
determine whether two variables are pointing to the same object. We
could do this with equal? as well, but let's play around with object_id.
```
str1 = "something"
str2 = "something"

str1.object_id            # => 70186013144280
str2.object_id            # => 70186013536580
```
When you run this on your computer, the numbers may not match the
output above, but the two numbers should be different. From the
above output, you can see that though str1 and str2 contain the same
value, they are indeed different objects. Because object_id returns
an integer, we can compare the object ids of various objects.
```
arr1 = [1, 2, 3]
arr2 = [1, 2, 3]
arr1.object_id == arr2.object_id      # => false

sym1 = :something
sym2 = :something
sym1.object_id == sym2.object_id      # => true

int1 = 5
int2 = 5
int1.object_id == int2.object_id      # => true
```
Interesting! This means that symbols and integers behave slightly
differently in Ruby than other objects. If two symbols or two integers
have the same value, they are also the same object. This is a
performance optimization in Ruby, because you can't modify a symbol
or integer. This is also why Rubyists prefer symbols over strings
to act as hash keys: it's a slight performance optimization and saves
on memory.

## The === method

There are two more concepts related to equality. The first is the
`=== method`. Just like ==, it looks like a built-in Ruby operator
when you use it, but it's in fact an instance method. The more
confusing part about this method is that it's used implicitly by the
case statement.

A good example of seeing === in action is when we have ranges in a
when clause.

```ruby
num = 25

case num
when 1..50
  puts "small number"
when 51..100
  puts "large number"
else
  puts "not in range"
end
```

Behind the scenes, the case statement is using the === method to compare each when clause with num. In this example, the when clauses contain only ranges, so Range#=== is used for each clause. Typically, you do not have to override the default === behavior, as you likely wouldn't use your custom classes in a case statement. It's sometimes useful to remember that === is used for comparison in case statements, though.

In order to visualize how the case statement uses ===, consider the following interpretation using an if statement:

num = 25

if (1..50) === num
  puts "small number"
elsif (51..100) === num
  puts "large number"
else
  puts "not in range"
end

In this example, the === method is invoked on a range and passes in the argument num. Now, === doesn't compare two objects the same way that == compares two objects. When === compares two objects, such as (1..50) and 25, it's essentially asking "if (1..50) is a group, would 25 belong in that group?" In this case, the answer is "yes". For further clarification, consider the following code:

String === "hello" # => true
String === 15      # => false

On line 1, true is returned because "hello" is an instance of String, even though "hello" doesn't equal String. Similarly, false is returned on line 2 because 15 is an integer, which doesn't equal String and isn't an instance of the String class.

Sidenote: the === operator in JavaScript is very different from its function in Ruby. Do not get the two confused.
eql?

Finally, we get to the last equality comparison method: eql?. The eql? method determines if two objects contain the same value and if they're of the same class. This method is used most often by Hash to determine equality among its members. It's not used very often.
Summary

This is probably too much to know about how Ruby handles equality, so we'll try to summarize the important points:
Most Important

==

    the == operator compares two objects' values, and is frequently used.
    the == operator is actually a method. Most built-in Ruby classes, like Array, String, Fixnum, etc override the == method to specify how to compare objects of those classes.
    if you need to compare custom objects, you should override the == method.
    understanding how this method works is the most important part of this assignment.

Less Important

equal?

    the equal? method goes one level deeper than == and determines whether two variables not only have the same value, but also whether they point to the same object.
    do not override equal?.
    the equal? method is not used very often.
    calling object_id on an object will return the object's unique numerical value. Comparing two objects' object_id has the same effect as comparing them with equal?.

===

    used implicitly in case statements.
    like ==, the === operator is actually a method.
    you rarely need to call this method explicitly, and only need to implement it in your custom classes if you anticipate your objects will be used in case statements, which is probably pretty rare.

eql?

    used implicitly by Hash.
    very rarely used explicitly.
