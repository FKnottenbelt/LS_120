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

require 'forwardable'
class Move
  attr_reader :moves
  extend Forwardable

  def_delegator :@moves, :sample, :random

  def initialize
    @moves = ['rock', 'paper', 'scissors', 'lizard', 'spock']
  end

  def format_moves
    "(r)ock, (p)aper, (s)cissors, (l)izard or (sp)ock"
  end

  def valid_move?(choice)
    choice = autocomplete_choice(choice) if choice.size <= 2
    moves.include?(choice)
  end

  def autocomplete_choice(choice)
    full_text = { r: 'rock',
                  p: 'paper',
                  s: 'scissors',
                  sp: 'spock',
                  l: 'lizard' }
    full_text[choice.to_sym]
  end

  def make(choice)
    choice = autocomplete_choice(choice) if choice.size <= 2
    @value = choice
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

  def to_s
    self.class.to_s
  end

  def >(other)
    #
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

class Player
  attr_accessor :move, :name
  def initialize
    set_name
    @move = Move.new
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
      puts "Please choose #{move.format_moves}: "
      choice = gets.chomp
      break if move.valid_move?(choice)
      puts "Sorry, invalid choice."
    end
    self.move = move.make(choice)
  end
end

class Computer < Player
  def set_name
    self.name = ['R2D2', 'Hal', 'Chappie', 'Sonny', 'Number 5'].sample
  end

  def choose
    self.move = move.make(move.random)
  end
end

class History
  attr_accessor :history
  def initialize
    @history = []
  end

  def remember(round)
    old_round = { human: round.human.name,
                  human_move: round.human.move,
                  human_score: round.score[:human],
                  computer: round.computer.name,
                  computer_move: round.computer.move,
                  computer_score: round.score[:computer] }
    @history << old_round
  end

  def display_history
    puts "Summary of the game:"
    puts "--------------------"
    history.each.with_index do |rnd, i|
        puts "Round #{i + 1}:"
        puts "#{rnd[:human]} choose #{rnd[:human_move]} and " \
          "#{rnd[:computer]} choose #{rnd[:computer_move]}."
        puts "The score was: " \
          "#{rnd[:human]}: #{rnd[:human_score]}" \
          " - #{rnd[:computer]}: #{rnd[:computer_score]}"
        puts
     end
  end
end

class RPSGame
  include Gameable

  attr_accessor :human, :computer, :game_winner, :score, :history
  WINNING_SCORE = 2

  def initialize
    clear_screen
    @human = Human.new
    @computer = Computer.new
    @score = { human: 0, computer: 0 }
    @game_winner = nil
    @history = History.new
  end

  def display_welcome_message
    puts "Welcome to Rock, Paper, Scissors #{human.name}!"
    puts "We will play a match where the first one to reach " \
      "#{WINNING_SCORE} points wins."
  end

  def display_goodbye_message
    puts "Thanks for playing Rock, Paper, Scissors. Goodbye!"
  end

  def display_moves
    puts
    puts "#{human.name} chose #{human.move}"
    puts "#{computer.name} chose #{computer.move} "
  end

  def display_score
    puts "The score is: #{human.name}: #{score[:human]}" \
      " - #{computer.name}: #{score[:computer]}"
    puts
  end

  def display_winner
    if winner
      puts "#{winner.name} won!"
    else
      puts "It's a tie!"
    end
  end

  def winner
    if human.move > computer.move
      human
    elsif computer.move > human.move
      computer
    end
  end

  def display_game_winner
    puts "#{game_winner} won this match!"
  end

  def update_score
    if winner == human
      score[:human] += 1
    elsif winner == computer
      score[:computer] += 1
    end
  end

  def setup_new_match
    clear_screen
    self.score = { human: 0, computer: 0 }
    self.game_winner = nil
  end

  def play_round
    until game_winner
      human.choose
      computer.choose
      display_moves
      update_score
      display_winner
      display_score
      history.remember(self)
      @game_winner = human.name if score[:human] == WINNING_SCORE
      @game_winner = computer.name if score[:computer] == WINNING_SCORE
    end
    history.display_history
  end

  def play
    display_welcome_message
    loop do
      play_round
      display_game_winner
      break unless play_again?
      setup_new_match
    end
    display_goodbye_message
  end
end

RPSGame.new.play
