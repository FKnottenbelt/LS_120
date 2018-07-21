require 'forwardable'

class Move
  attr_reader :moves
  extend Forwardable

  def_delegator :@moves, :sample, :random


  def initialize
  # @moves = ['rock', 'paper', 'scissors', 'lizard', 'spock']
   @moves = make_moves

   puts "available moves #{@moves}"
  end
##########
  def self.make_moves
    @make_moves
  end

  def make_moves
    self.class.make_moves = 'all'
    self.class.make_moves
  end

  def self.make_moves=(n)
     @make_moves = ObjectSpace.each_object(Class).select { |klass| klass < self }
  end
##############
  def format_moves
    values = moves.dup
    values << values.pop(2).join(' or ')
    values.join(', ')
  end

  def valid_move?(choice)
    moves.include?(choice)
  end

  def make(choice)
    @value = choice
    case choice
    when 'rock'
      Rock.allocate
    when 'paper'
      Paper.allocate
    when 'scissors'
      Scissors.allocate
    when 'lizard'
      Lizard.allocate
    when 'spock'
      Spock.allocate
    end

  end

  # def self.descendants
  #   p self
  #   # The ObjectSpace module contains a number of routines that
  #   # interact with the garbage collection facility and allow you
  #   # to traverse all living objects with an iterator.
  #   # So we get an array of descentants of Move. (as opposed to
  #   # ancestors.)
  #   ObjectSpace.each_object(Class).select { |klass| klass < self }
  # end

  def to_s
    @value
  end
end

class Human
  attr_accessor :move
  def choose
    move = Move.new
    choice = nil
    loop do
      puts "Please choose #{move.format_moves}: "
      choice = gets.chomp
      break if move.valid_move?(choice)
      puts "Sorry, invalid choice."
    end
   p self.move = move.make(choice)
  end
end

class Computer
    attr_accessor :move
  def choose
    move = Move.new
    p self.move = move.make(move.random)
  end
end

class Lizard < Move
  def >(other)
    other.class == Spock || other.class == Paper
  end

  def to_s
    'Lizard'
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

m1 = Move.new.make('lizard')
m2 =  Move.new.make('spock')
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

#p Move.descendants

# m3 = Move.new
# m3.options
bob = Human.new
bob.choose
hal = Computer.new
hal.choose
