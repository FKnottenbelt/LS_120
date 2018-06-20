# Modify the following code so that the value of @phone_number
# can't be modified outside the class.
#
# class Person
#   attr_accessor :phone_number
#
#   def initialize(number)
#     @phone_number = number
#   end
# end
#
# person1 = Person.new(1234567899)
# puts person1.phone_number
#
# person1.phone_number = 9987654321
# puts person1.phone_number
#
# Expected output:
#
# 1234567899
# NoMethodError

class Person
  attr_reader :phone_number

  def initialize(number)
    @phone_number = number
  end

  def self.me_only=(number)
    @phone_number = number
  end

  def self.phone_number
    @phone_number
  end
end

person1 = Person.new(1234567899)
puts person1.phone_number

#person2 = Person.new(11001)
#puts person2.me_only(110011) # undefined method `phone_number'
Person.me_only = 220022
puts person1.phone_number # 1234567899
puts Person.phone_number  # 220022

p '--'

person1.phone_number = 9987654321
puts person1.phone_number
# undefined method `phone_number='

