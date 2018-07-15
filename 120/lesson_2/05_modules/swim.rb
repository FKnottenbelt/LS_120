module Swim
  def swim
    'swimming!'
  end
end

class Animal
  def run
    'running!'
  end

  def jump
    'jumping!'
  end
end

class Dog < Animal
  include Swim

  def speak
    'bark!'
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

class Fish < Animal
  include Swim
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
nemo = Fish.new
fido = Dog.new

bob.pets << kitty
bob.pets << bud

p bob.class  # Person
p bob.pets  #[#<Cat:0x00000000c51318>, #<Bulldog:0x00000000c51340>]
p bob.pets.class # Array
puts

bob.pets.each do |pet|
  p "#{pet.class} " + pet.jump
end
puts
p nemo.swim # "swimming!"
p fido.swim # "swimming!"
p bud.swim # "can't swim!"
p kitty.swim # undefined method `swim' for #<Cat
