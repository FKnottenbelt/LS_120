class Animal
  def speak
    "hello"
  end
end

class GoodDog < Animal
  attr_accessor :name

  def initialize(n)
    self.name = n    # @name will also work
  end

  def speak
    super + "from the GoodDog class"
  end
end

class Cat < Animal
end

sparky = GoodDog.new("Sparky")
fido = GoodDog.new("Fido")
paws = Cat.new
puts sparky.speak
puts paws.speak
puts fido.speak