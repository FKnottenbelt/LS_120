# Further Exploration

# What would happen in this case?

# name = 42
# fluffy = Pet.new(name)
# name += 1
# puts fluffy.name
# puts fluffy
# puts fluffy.name
# puts name
# #
class Pet
  attr_reader :name

  def initialize(name)
    @name = name.to_s
  end

  def to_s
    @name.upcase!
    "My name is #{@name}."
  end
end
#


class Pet
  attr_reader :name

  def initialize(name)
    @name = name.to_s # to_s called on int returns new string
    p @name.object_id # object id B
    p name.object_id # object id A
    p '--'
  end

  def to_s
    @name.upcase!
    p @name.object_id # object id B
    "My name is #{@name.upcase}."
  end
end

name = 42 # object id A
p name.object_id
fluffy = Pet.new(name)
name += 1  # reassigning  object id C
p name.object_id
puts fluffy.name
puts fluffy
puts fluffy.name
puts name
puts fluffy.name