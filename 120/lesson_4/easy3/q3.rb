=begin
When objects are created they are a separate realization of a particular
class.

Given the class below, how do we create two different instances of this
class, both with separate names and ages?

class AngryCat
  def initialize(age, name)
    @age  = age
    @name = name
  end

  def age
    puts @age
  end

  def name
    puts @name
  end

  def hiss
    puts "Hisssss!!!"
  end
end
=end

class AngryCat
  def initialize(age, name)
    @age  = age
    @name = name
  end

  def age
    puts @age
  end

  def name
    puts @name
  end

  def hiss
    puts "Hisssss!!!"
  end
end

tommy = AngryCat.new('Tommy', 2)
black = AngryCat.new('Black', 12)
tommy.name
black.name
tommy.age
black.age
