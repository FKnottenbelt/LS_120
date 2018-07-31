=begin
What is the default return value of to_s when invoked on an object?
Where could you go to find out if you want to be sure?
=end

# A
# the object

class Person
end

bob = Person.new
puts bob
#<Person:0x000000023be898>

# By default, the to_s method will return the name of the object's 
# class and an encoding of the object id.