# Using the code from the previous exercise, add an #initialize method that
# prints I'm a cat! when a new Cat object is initialized.
#
# Code:
#
# class Cat
# end
#
# kitty = Cat.new
#
# Expected output:
#
# I'm a cat!

class Cat

  def initialize
    puts "I am a cat!"
  end

end

kitty = Cat.new