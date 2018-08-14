## 1 - ls book, chaper 3, good_dog2.rb
refactor:

class GoodDog
  @@number_of_dogs = 0

  def initialize
    @@number_of_dogs += 1
  end

  def self.total_number_of_dogs
    @@number_of_dogs
  end
end


puts GoodDog.total_number_of_dogs   # => 0

dog1 = GoodDog.new
dog2 = GoodDog.new

puts GoodDog.total_number_of_dogs   # => 2

## 2 - Cars and hybrid cars. manning chapter 5.2.5

Car.add_make("Honda")
Car.add_make("Ford")
h = Car.new("Honda")
f = Car.new("Ford")
h2 = Car.new("Honda")
Creating a new Honda!
Creating a new Ford!
Creating a new Honda!
puts "Counting cars of same make as h2..."
puts "There are #{h2.make_mates}."
puts "Counting total cars..."
puts "There are #{Car.total_count}."
Counting total cars...
There are 3.
x = Car.new("Brand X")
car.rb:21:in `initialize': No such make: Brand X. (RuntimeError)

### part 2:
class Hybrid < Car
end
hy = Hybrid.new("Honda")
puts "There are #{Hybrid.total_count} hybrids in existence!"
h3 = Hybrid.new("Honda")
f2 = Hybrid.new("Ford")
puts "There are #{Hybrid.total_count} hybrids on the road!"

## more class variable versus class instance variable
see ~/ls_solo/OOP_manning/more_on_class_variables.rb

## Accessor methods
#=> 120/small_problems/04_accessor_methods/07_prefix_the_name.rb
Using the following code, add the appropriate accessor methods so that @name
is returned with the added prefix 'Mr.'.

class Person
end

person1 = Person.new
person1.name = 'James'
puts person1.name

Expected output:

Mr. James

## 3 - Pet Shelter
120/small_problems/06_easy2/07_pet_shelter.rb

## 4 - Nobility
120/small_problems/06_easy2/10_nobility.rb

## Operator overloading (??)
unclear if I need this.
https://strugglingwithruby.blogspot.com/2010/04/operator-overloading.html
see also
https://www.tutorialspoint.com/ruby/ruby_object_oriented.htm

## constructors (??)
what is a constructor?
The new method is a constructor: a method whose purpose is to manufacture and return to you a new instance of the class, a newly minted object.

erhm? vs:
A constructor is a special kind of a method. It is automatically called when an object is created. Constructors do not return values. The purpose of the constructor is to initiate the state of an object. The constructor in Ruby is called initialize. Constructors do not return any values.
(zetcode and www.tutorialspoint.com)

## Privacy
120/small_problems/07_medium1/01_privacy.rb
120/lesson_4/medium1/q3.rb

## Fixed Array
120/small_problems/07_medium1/02_fixed_array.rb

## practicing classes and objects
~/ls_solo/120/lesson_2/01_classes_and_objects

## find out how to test user input loops with wrong input
will have to wait to 130...

## quizz lesson nr 2
see file: Collaborator object (lesson forum).rb

## lexical scope?
http://blog.honeybadger.io/lexical-scoping-and-ruby-class-variables/
/120/lesson_3/03_variable_scope/variable_scope.mdf
file: lexcical scope (ls forum).rb

## quizz lesson nr 3

## benefits of using Object Oriented Programming in Ruby
lesson 4, easy 2, q10

## talking about code
~/120/lesson_4/easy3/q1.rb
~/120/lesson_4/easy2/q7.rb
~/120/lesson_4/easy2/q3.rb
~/120/lesson_4/easy2/q1.rb
/120/lesson_4/easy3/q5.rb
~/120/lesson_4/medium1/q1.rb
~/120/lesson_4/medium1/q2.rb

#
/120/lesson_4/easy3/q2.rb
/120/lesson_4/medium1/q5.rb
/120/lesson_4/hard1/q2.rb
/120/lesson_4/hard1/q3.rb
/120/lesson_4/hard1/q4.rb

# ruby tricky code
05_03_ttt_spike.md step 8

# namespaces
see 05_05 point 3. Find out more. (example?)

# look at
/120/small_problems/07_medium1/05b_ls_stack_machine.rb