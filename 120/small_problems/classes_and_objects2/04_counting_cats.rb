# Using the following code, create a class named Cat that tracks the
# number of times a new Cat object is instantiated. The total number of
# Cat instances should be printed when #total is invoked.
#
# kitty1 = Cat.new
# kitty2 = Cat.new
#
# Cat.total
#
# Expected output:
#
# 2

class Cat

  def initialize
    self.class.total += 1
  end

  def self.total
    @no_of_cats ||= 0
  end

  def self.total=(n)
    @no_of_cats = n
  end

end

kitty1 = Cat.new
kitty2 = Cat.new

p Cat.total

# ls solution
class Cat
  @@number_of_cats = 0

  def initialize
    @@number_of_cats += 1
  end

  def self.total
    puts @@number_of_cats
  end
end