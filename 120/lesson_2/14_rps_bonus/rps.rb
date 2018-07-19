module Gameable
  def play_again?
    answer = ''
    loop do
      puts "Would you like to play again? (y/n)"
      answer = gets.chomp.downcase
      break if %w[y yeah yes yep n no nope].include?(answer)
      puts 'Please answer y (yes) or n (no)'
    end
    %w[y yeah yes yep].include?(answer)
  end

  def clear_screen
    system("cls") || system("clear")
  end
end

class Move
  VALUES = ['rock', 'paper', 'scissors']
   # VALUES = ['rock', 'paper', 'scissors', 'lizard', 'spock']
  #MOVES = [Rock.new, Paper.new, Scissors.new, Lizard.new, Spock.new]
  # def initialize(value)
  #   @value = value
  # end

  def self.make(choice)
    case choice
    when 'rock'
      Rock.new
    when 'paper'
      Paper.new
    when 'scissors'
      Scissors.new
    end

  end

  # def scissors?
  #   @value == 'scissors'
  # end

  # def rock?
  #   @value == 'rock'
  # end

  # def paper?
  #   @value == 'paper'
  # end

  # def >(other_move)
  #   (rock? && other_move.scissors?) ||
  #     (scissors? && other_move.paper?) ||
  #     (paper? && other_move.rock?)
  # end

  # def <(other_move)
  #   (rock? && other_move.paper?) ||
  #     (scissors? && other_move.rock?) ||
  #     (paper? && other_move.scissors?)
  # end

  def to_s
    @value
  end
end

class Rock < Move
  attr_reader :name
  def initialize
    @name = 'rock'
  end

  def beats(other)
    ['scissors', 'lizard'].include?(other.name)
  end
end

class Scissors < Move
  attr_reader :name
  def initialize
    @name = 'scissors'
  end

  def beats(other)
    ['paper', 'lizard'].include?(other.name)
  end
end

class Paper < Move
  attr_reader :name
  def initialize
    @name = 'paper'
  end
  def beats(other)
    ['rock', 'spock'].include?(other.name)
  end
end

class Player
  attr_accessor :move, :name
  def initialize
    set_name
  end
end

class Human < Player
  def set_name
    n = ''
    loop do
      puts "What's your name?"
      n = gets.chomp
      break unless n.empty?
      puts "Sorry, must enter a value"
    end
    self.name = n
  end

  def choose
    choice = nil
    loop do
      puts "Please choose rock, paper, sissors, lizard or spock:"
      choice = gets.chomp
      break if Move::VALUES.include?(choice)
      puts "Sorry, invalid choice."
    end
    self.move = Move.make(choice)
  end
end

class Computer < Player
  def set_name
    self.name = ['R2D2', 'Hal', 'Chappie', 'Sonny', 'Number 5'].sample
  end

  def choose
   self.move = Move.make(Move::VALUES.sample)
  end
end

class RPSGame
  include Gameable

  attr_accessor :human, :computer, :rounds, :winner, :score
  WINNING_SCORE = 2

  def initialize
    clear_screen
    @human = Human.new
    @computer = Computer.new
    @rounds = []
    @score = { human: 0, computer: 0 }
    @winner = nil
  end

  def display_welcome_message
    puts "Welcome to Rock, Paper, Scissors #{human.name}!"
    puts "We will play a match where the first one to reach " \
      "#{WINNING_SCORE} points wins."
  end

  def display_goodbye_message
    puts "Thanks for playing Rock, Paper, Scissors. Goodbye!"
  end

  def display_winner
    puts "#{self.winner.name} won this match!"
  end

  def setup_new_match
    clear_screen
    self.score = { human: 0, computer: 0 }
    self.winner = nil
  end

  def play_round
    until winner
      rounds << Round.new(self)
      rounds.last.play
      @winner = human if score[:human] == WINNING_SCORE
      @winner = computer if score[:computer] == WINNING_SCORE
    end
  end

  def play
    display_welcome_message
    loop do
      play_round
      display_winner
      break unless play_again?
      setup_new_match
    end
    display_goodbye_message
  end
end

class Round
  attr_accessor :human, :computer, :score

  def initialize(game)
    @game = game
    @human = game.human
    @computer = game.computer
    @score = game.score
  end

  def display_moves
    puts
    puts "#{human.name} chose #{human.move}"
    puts "#{computer.name} chose #{computer.move} "
  end

  def winner
    if human.move.beats computer.move
      human
    elsif computer.move.beats human.move
      computer
    end
  end

  def update_score
    if winner == human
      score[:human] += 1
    elsif winner == computer
      score[:computer] += 1
    end
  end

  def display_winner
    if winner
      puts "#{winner.name} won!"
    else
      puts "It's a tie!"
    end
  end

  def display_score
    puts "The score is: #{human.name}: #{score[:human]}" \
      " - #{computer.name}: #{score[:computer]}"
    puts
  end

  def play
    human.choose
    computer.choose
    display_moves
    update_score
    display_winner
    display_score
  end
end



RPSGame.new.play
