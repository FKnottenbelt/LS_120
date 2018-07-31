=begin
Given the class below, if we created a new instance of the class and
then called to_s on that instance we would get something like
"#<Cat:0x007ff39b356d30>"

class Cat
  def initialize(type)
    @type = type
  end
end

How could we go about changing the to_s output on this method to look
like this: I am a tabby cat? (this is assuming that "tabby" is the type
we passed in during initialization).
=end

class Cat
  attr_reader :type

  def initialize(type)
    @type = type
  end

  def to_s
    "I am a #{type} cat"
  end
end

kitty = Cat.new('tabby')
puts kitty

# ls
# We can customize existing methods like this easily, but in many
# cases it might be better to write a new method called something
# like display_type instead, as this is more specific about what we
# are actually wanting the result of the method to be. An example of
# this would be:

class Cat
  attr_reader :type

  def initialize(type)
    @type = type
  end

  def display_type
    puts "I am a #{type} cat"
  end
end