# Consider the following program.
#
# class Pet
#   def initialize(name, age)
#     @name = name
#     @age = age
#   end
# end
#
# class Cat < Pet
# end
#
# pudding = Cat.new('Pudding', 7, 'black and white')
# butterscotch = Cat.new('Butterscotch', 10, 'tan and white')
# puts pudding, butterscotch
#
# Update this code so that when you run it, you see the following output:
#
# My cat Pudding is 7 years old and has black and white fur.
# My cat Butterscotch is 10 years old and has tan and white fur.

# nicer solution
class Pet
  def initialize(args)
    @name = args[:name]
    @age = args[:age]
    post_intialize(args)
  end

  def post_intialize(args)
    nil
  end
end

class Cat < Pet
  attr_reader :name, :age, :fur

  def post_initialize(args)
    @fur = args[:fur]
  end

  def to_s
    "My cat #{name} is #{age} years old and has #{fur} fur."
  end
end

pudding = Cat.new(name:'Pudding', age: 7, fur: 'black and white')
butterscotch = Cat.new(name: 'Butterscotch', age: 10, fur: 'tan and white')
puts pudding, butterscotch

# easy soltion
class Pet
  def initialize(name, age)
    @name = name
    @age = age
  end
end

class Cat < Pet
  attr_reader :name, :age, :fur

  def initialize(name, age, fur)
    @fur = fur
    super(name, age)
  end

  def to_s
    "My cat #{name} is #{age} years old and has #{fur} fur."
  end
end

pudding = Cat.new('Pudding', 7, 'black and white')
butterscotch = Cat.new('Butterscotch', 10, 'tan and white')
puts pudding, butterscotch

# ls solution
class Pet
  def initialize(name, age)
    @name = name
    @age = age
  end
end

class Cat < Pet
  def initialize(name, age, fur)
    super(name, age)
    @fur = fur
  end

  def to_s
    "My cat #{@name} is #{@age} years old and has #{@fur} fur."
  end
end

pudding = Cat.new('Pudding', 7, 'black and white')
butterscotch = Cat.new('Butterscotch', 10, 'tan and white')
puts pudding, butterscotch
