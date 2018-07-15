=begin
Continuing with our Person class definition, what does the below print out?

bob = Person.new("Robert Smith")
puts "The person's name is: #{bob}"

fix the problem
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

  def to_s
    name
  end
end

bob = Person.new("Robert Smith")
puts "The person's name is: #{bob}"
# if we do not have a to_s method we can use, we must use string
# concatenation:
puts "The person's name is: " + bob.name