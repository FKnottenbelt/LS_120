# Modify the following code so that Hello! I'm a cat! is printed when
# Cat.generic_greeting is invoked.
#
# class Cat
# end
#
# Cat.generic_greeting
#
# Expected output:
#
# Hello! I'm a cat!

class Cat
  def self.generic_greeting
    puts "Hello! I'm a cat!"
  end
end

Cat.generic_greeting

kitty = Cat.new
#p kitty.generic_greeting # => undefined method `generic_greeting' for #<Cat:0x007fbdd3875e40> (NoMethodError)

#####
# Further Exploration

# What happens if you run kitty.class.generic_greeting? Can you
# explain this result?

p kitty.class
# Cat
kitty.class.generic_greeting
#'Hello! I'm a cat!'
