# good_dog.rb

class GoodDog
  def initialize(name)
    @name = name
  end

  def speak
    "#{@name} says arf!"
  end

  def name                  # This was renamed from "get_name"
    @name
  end

  def name=(n)              # This was renamed from "set_name="
    @name = n
  end
end

sparky = GoodDog.new("Sparky")
puts sparky.speak

fido = GoodDog.new("Fido")
puts fido.speak

puts sparky.get_name
sparky.set_name = "Spartacus"
puts sparky.get_name