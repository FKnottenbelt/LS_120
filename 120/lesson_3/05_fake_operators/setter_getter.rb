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

  def [](idx)
    members[idx]
  end

  def []=(idx, obj)
    members[idx] = obj
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

p cowboys.members
#[#<Person:0x000000014994a8 @name="Troy Aikman", @age=48>,
#<Person:0x00000001499458 @name="Emmitt Smith", @age=46>,
#<Person:0x00000001499408 @name="Michael Irvin", @age=49>]
p cowboys[1]
#<Person:0x00000001499458 @name="Emmitt Smith", @age=46>
cowboys[3] = Person.new("JJ", 72)
p cowboys[3]
#<Person:0x00000001498e40 @name="JJ", @age=72>
