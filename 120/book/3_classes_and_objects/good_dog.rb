# good_dog.rb

class GoodDog
  attr_accessor :name, :height, :weight

  def initialize(n, h, w)
    @name = n
    @height = h
    @weight = w
  end

  def speak
    "#{self.name} says arf!"
  end

  def change_info(n, h, w)
    self.name = n
    self.height = h
    self.weight = w
  end

  def info
    "#{self.name} weighs #{self.weight} and is #{self.height} tall."
  end

  def self.what_am_i         # Class method definition
    "I'm a GoodDog class!"
  end
end

# sparky = GoodDog.new("Sparky")
# puts sparky.speak

# fido = GoodDog.new("Fido")
# puts fido.speak

# puts sparky.get_name
# sparky.set_name = "Spartacus"
# puts sparky.get_name

sparky = GoodDog.new('Sparky', '12 inches', '10 lbs')
puts sparky.info      # => Sparky weighs 10 lbs and is 12 inches tall.

sparky.change_info('Spartacus', '24 inches', '45 lbs')
puts sparky.info      # => Spartacus weighs 45 lbs and is 24 inches tall.
puts sparky.speak

p GoodDog.what_am_i