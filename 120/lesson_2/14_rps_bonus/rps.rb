class Move
  VALUES = ['rock', 'paper', 'scissors']
  def initialize(value)
    @value = value
  end

  def scissors?
    @value == 'scissors'
  end

  def rock?
    @value == 'rock'
  end

  def paper?
    @value == 'paper'
  end

  def >(other_move)
    (rock? && other_move.scissors?) ||
      (scissors? && other_move.paper?) ||
      (paper? && other_move.rock?)
  end

  def <(other_move)
    (rock? && other_move.paper?) ||
      (scissors? && other_move.rock?) ||
      (paper? && other_move.scissors?)
  end

  def to_s
    @value
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
      puts "Please choose rock, paper, or sissors:"
      choice = gets.chomp
      break if Move::VALUES.include?(choice)
      puts "Sorry, invalid choice."
    end
    self.move = Move.new(choice)
  end
end

class Computer < Player
  def set_name
    self.name = ['R2D2', 'Hal', 'Chappie', 'Sonny', 'Number 5'].sample
  end

  def choose
    self.move = Move.new(Move::VALUES.sample)
  end
end

class RPSGame
  attr_accessor :human, :computer, :rounds
  SCORE = { human: 0, computer: 0}
  MATCH_ROUNDS = 2

  def initialize
    @human = Human.new
    @computer = Computer.new
    @rounds = []
  end

  def display_welcome_message
    puts "Welcome to Rock, Paper, Scissors!"
  end

  def display_goodbye_message
    puts "Thanks for playing Rock, Paper, Scissors. Goodbye!"
  end

  def play_again
    answer = nil
    loop do
      puts "Would you like to play again? (y/n)"
      answer = gets.chomp
      break if ['y', 'n'].include? answer.downcase
      puts "Sorry, must be y or n"
    end

    return false if answer.downcase == 'n'
    return true if answer.downcase == 'y'
  end

  def play
    display_welcome_message

    MATCH_ROUNDS.times do  # change to first to reach!
      rounds << Round.new(self)
      rounds.last.play
    end

    #break unless game.play_again
    display_goodbye_message
  end
end

class Round
 SCORE = { human: 0, computer: 0}
 attr_accessor :round_nr, :human, :computer, :game

  def initialize(game)
    @game = game
    @human = game.human
    @computer = game.computer
  end

  def display_moves
    puts "#{human.name} chose #{human.move}"
    puts "#{computer.name} chose #{computer.move} "
  end

  def display_winner
    if human.move > computer.move
      puts "#{human.name} won!"
      SCORE[:human] += 1
    elsif human.move < computer.move
      puts "#{computer.name} won!"
      SCORE[:computer] += 1
    else
      puts "It's a tie!"
    end
  end

  def display_score
    puts "The score is: #{human.name}: #{SCORE[:human]}" +
      " - #{computer.name}: #{SCORE[:computer]}"
      puts
  end

  def play
    human.choose
    computer.choose
    display_moves
    display_winner
    display_score
  end
end

RPSGame.new.play
