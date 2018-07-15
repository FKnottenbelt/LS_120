=begin
Using the class definition from step #3, let's create a few more people
-- that is, Person objects.

bob = Person.new('Robert Smith')
rob = Person.new('Robert Smith')

If we're trying to determine whether the two objects contain the same
name, how can we compare the two objects?
=end

class Person
  attr_accessor :first_name, :full_name, :last_name

  def initialize(name)
    self.name = name
  end

  def name
    [first_name, last_name].join(' ').strip
  end

  def name=(name)
    @first_name, @last_name = name.split
    self.last_name = '' if last_name.nil?
  end
end

bob = Person.new('Robert Smith')
rob = Person.new('Robert Smith')
p bob.name == rob.name

