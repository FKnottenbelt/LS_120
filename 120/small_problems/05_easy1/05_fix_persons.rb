# Complete this program so that it produces the expected output:
#
# class Person
#   def initialize(first_name, last_name)
#     @first_name = first_name.capitalize
#     @last_name = last_name.capitalize
#   end
#
#   def to_s
#     "#{@first_name} #{@last_name}"
#   end
# end
#
# person = Person.new('john', 'doe')
# puts person
#
# person.first_name = 'jane'
# person.last_name = 'smith'
# puts person
#
# Expected output:
#
# John Doe
# Jane Smith

class Person
  attr_accessor :first_name, :last_name

  def initialize(first_name, last_name)
    @first_name = first_name
    @last_name = last_name
  end

  def to_s
    "#{first_name.capitalize} #{last_name.capitalize}"
  end
end

person = Person.new('john', 'doe')
puts person

person.first_name = 'jane'
person.last_name = 'smith'
puts person

# ls solution:
class Person
  attr_writer :first_name, :last_name

  def initialize(first_name, last_name)
    @first_name = first_name.capitalize
    @last_name = last_name.capitalize
  end

  def first_name=(value)
    @first_name = value.capitalize
  end

  def last_name=(value)
    @last_name = value.capitalize
  end

  def to_s
    "#{@first_name} #{@last_name}"
  end
end
