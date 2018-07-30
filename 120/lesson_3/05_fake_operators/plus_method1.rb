class Person
  attr_accessor :name, :age

  def initialize(name, age)
    @name = name
    @age = age
  end
end

class Team
  attr_accessor :name, :members

  def initialize(name)
    @name = name
    @members = []
  end

  def <<(person)
    members.push person
  end

  def +(other_team)
    members + other_team.members
  end
end

cowboys = Team.new("Dallas Cowboys")
cowboys << Person.new("Troy Aikman", 48)
cowboys << Person.new("Emmitt Smith", 46)
cowboys << Person.new("Michael Irvin", 49)

niners = Team.new("San Francisco 49ers")
niners << Person.new("Joe Montana", 59)
niners << Person.new("Jerry Rice", 52)
niners << Person.new("Deion Sanders", 47)

p dream_team = cowboys + niners
# [#<Person:0x00000001916300 @name="Troy Aikman", @age=48>,
#<Person:0x00000001916288 @name="Emmitt Smith", @age=46>,
#<Person:0x00000001916238 @name="Michael Irvin", @age=49>,
#<Person:0x00000001916170 @name="Joe Montana", @age=59>,
#<Person:0x000000019160f8 @name="Jerry Rice", @age=52>,
#<Person:0x000000019160a8 @name="Deion Sanders", @age=47>]