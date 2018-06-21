# Using the following code, add the appropriate accessor methods. Keep in mind
# that @age should only be visible to instances of Person.
#
# class Person
#   def older_than?(other)
#     age > other.age
#   end
# end
#
# person1 = Person.new
# person1.age = 17
#
# person2 = Person.new
# person2.age = 26
#
# puts person1.older_than?(person2)
#
# Expected output:
#
# false

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

=begin
When a method is private, only the class - not instances of the class
- can access it. However, when a method is protected, only instances of
the class or a subclass can call the method. This means we can easily
share sensitive data between instances of the same class type.

In the solution, we implement a method that compares the ages of two
people. The getter method is protected, though, which means we can
only access it from another instance of the same class. Therefore,
we have to invoke older_than? on an existing instance, and pass in
another instance as an argument. We can then compare the two ages
to determine who is older.
=end