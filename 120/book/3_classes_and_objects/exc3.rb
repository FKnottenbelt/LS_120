class Person
  attr_accessor :name # change attr_reader

  def initialize(name)
    @name = name
  end
end

bob = Person.new("Steve")
bob.name = "Bob"
