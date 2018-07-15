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
  attr_accessor :name, :pet

  def initialize(name)
    @name = name
  end
end

bob = Person.new('Robert')
bud = Bulldog.new
bob.pet = bud

p bob.class  # Person
p bob.pet    #<Bulldog:0x00000001d0e200>
p bob.pet.class #Bulldog

p bob.pet.speak # "bark!"
p bob.pet.fetch # "fetching!"