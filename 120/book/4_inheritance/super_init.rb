class Animal
  attr_accessor :name

  def initialize(name)
    @name = name
  end

  def speak
    "hello"
  end
end

class GoodDog < Animal

  def initialize(color)
    super  # takes color and passes it up the chain
    @color = color  # uses input color
  end

  def speak
    super + " from the GoodDog class"
  end
end

class Cat < Animal
  def speak
    "Miauw"
  end
end


bruno = GoodDog.new("brown")
sparky = GoodDog.new("Sparky")
fido = GoodDog.new("Fido")
paws = Cat.new("Paws")
puts sparky.speak
puts paws.speak
puts fido.speak
p bruno.color
# super_init.rb:39:in `<main>': undefined method `color'
# for #<GoodDog:0x00000002516858 @name="brown", @color="brown">
# (NoMethodError)
p sparky.color
p fido.color
p paws.color