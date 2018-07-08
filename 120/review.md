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