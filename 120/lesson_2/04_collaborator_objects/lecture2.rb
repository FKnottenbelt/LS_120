class Animal
  def run
    'running!'
  end

  def jump
    'jumping!'
  end
end

class Dog < Animal
  def speak
    'bark!'
  end

  def swim
    'swimming!'
  end

  def fetch
    'fetching!'
  end
end

class Bulldog < Dog
  def swim
    "can't swim!"
  end
end

class Cat < Animal
  def speak
    'miaouw!'
  end
end

class Person
  attr_accessor :name, :pets

  def initialize(name)
    @name = name
    @pets = []
  end
end

bob = Person.new('Bob')
bud = Bulldog.new
kitty = Cat.new

bob.pets << kitty
bob.pets << bud

p bob.class  # Person
p bob.pets  #[#<Cat:0x00000000c51318>, #<Bulldog:0x00000000c51340>]
p bob.pets.class # Array
puts

bob.pets.each do |pet|
  p "#{pet.class} " + pet.jump
end
