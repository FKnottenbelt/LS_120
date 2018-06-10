class Animal
  attr_accessor :name

  def initialize(name)
    @name = name
  end

  def speak
    "hello"
  end
end

class BadDog < Animal
  def initialize(age, name)
    super(name)
    @age = age
  end
end

p BadDog.new(2, "bear")
# #<BadDog:0x00000001c090d0 @name="bear", @age=2>