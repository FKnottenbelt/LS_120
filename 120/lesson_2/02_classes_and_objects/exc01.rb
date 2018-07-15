=begin
Given the below usage of the Person class, code the class definition.

bob = Person.new('bob')
bob.name                  # => 'bob'
bob.name = 'Robert'
bob.name                  # => 'Robert'
=end

class Person
  attr_accessor :name

  def initialize(name)
    @name = name
  end
end

bob = Person.new('bob')
p bob.name                  # => 'bob'
bob.name = 'Robert'
p bob.name                  # => 'Robert'

require 'minitest/autorun'

class PeronTest < MiniTest::Test
  def setup
    @johan = Person.new('bob')
  end

  def test_name_can_be_changed
    @johan.name = 'Johan'
    assert_equal 'Johan', @johan.name
  end
end