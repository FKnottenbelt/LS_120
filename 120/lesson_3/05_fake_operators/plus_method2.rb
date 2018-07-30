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
    temp_team = Team.new("Temporary Team")
    temp_team.members = members + other_team.members
    temp_team
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
#<Team:0x00000000ce1a30 @name="Temporary Team", @members=[
#<Person:0x00000000ce1d00 @name="Troy Aikman", @age=48>,
#<Person:0x00000000ce1cb0 @name="Emmitt Smith", @age=46>,
#<Person:0x00000000ce1c38 @name="Michael Irvin", @age=49>,
#<Person:0x00000000ce1b20 @name="Joe Montana", @age=59>,
#<Person:0x00000000ce1ad0 @name="Jerry Rice", @age=52>,
#<Person:0x00000000ce1a80 @name="Deion Sanders", @age=47>]>