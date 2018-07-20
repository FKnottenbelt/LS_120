class Move
  VALUES = ['rock', 'paper', 'scissors']

   # VALUES = ['rock', 'paper', 'scissors', 'lizard', 'spock']
  #MOVES = [Rock.new, Paper.new, Scissors.new, Lizard.new, Spock.new]

  def self.make(choice)
    case choice
    when 'rock'
      Rock.new
    when 'paper'
      Paper.new
    when 'scissors'
      Scissors.new
    when 'lizard'
      Lizard.new
    when 'spock'
      Spock.new
    end

  end

  def self.descendants
    # The ObjectSpace module contains a number of routines that
    # interact with the garbage collection facility and allow you
    # to traverse all living objects with an iterator.
    # So we get an array of descentants of Move. (as opposed to
    # ancestors.)
    ObjectSpace.each_object(Class).select { |klass| klass < self }
  end

  def to_s
    @value
  end
end

class Lizard < Move
  def >(other)
    other.class == Spock || other.class == Paper
  end
end

class Spock < Move
  def >(other)
    other.class == Scissors || other.class == Rock
  end
end

class Rock < Move
  def >(other)
    other.class == Scissors || other.class == Lizard
  end
end

class Scissors < Move
  def >(other)
    other.class == Paper || other.class == Lizard
  end
end

class Paper < Move
  def >(other)
    other.class == Rock || other.class == Spock
  end
end



#============================

m1 = Move.make('lizard')
m2 =  Move.make('spock')
p m1
p m2

if m1 > m2
  puts "m1 beats m2"
else
  puts 'no m1 beats m2'
end
if m2 > m1
  puts "m2 beats m1"
else
  puts "no m2 beats m1"
end

p Move.descendants