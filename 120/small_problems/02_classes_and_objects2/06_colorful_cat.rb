# Using the following code, create a class named Cat that prints a greeting
# when #greet is invoked. The greeting should include the the name and
# color of the cat. Use a constant to define the color.
#
# kitty = Cat.new('Sophie')
# kitty.greet
#
# Expected output:
#
# Hello! My name is Sophie and I'm a purple cat!

class Cat
  COLOR = ['purple', 'blue', 'red']
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def greet
    puts "Hello! My name is #{name} and I'm a #{COLOR.sample} cat!"
  end
end

kitty = Cat.new('Sophie')
kitty.greet