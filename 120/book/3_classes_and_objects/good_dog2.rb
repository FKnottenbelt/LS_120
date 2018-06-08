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
puts "on to second version"
puts

######## better version?

class GoodDog2

  def initialize
    self.class.number_of_dogs += 1
  end

  def self.number_of_dogs
    @number_of_dogs ||= 0
  end

  def self.number_of_dogs=(n)
    @number_of_dogs = n
  end

  def self.total_number_of_dogs
    self.number_of_dogs
  end
end


puts GoodDog2.total_number_of_dogs   # => 0

dog1 = GoodDog2.new
dog2 = GoodDog2.new

puts GoodDog2.number_of_dogs

puts GoodDog2.total_number_of_dogs   # => 2