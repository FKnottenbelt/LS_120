=begin
Create an object-oriented number guessing class for numbers in the
range 1 to 100, with a limit of 7 guesses per game. The game should
play like this:

game = GuessingGame.new
game.play

You have 7 guesses remaining.
Enter a number between 1 and 100: 104
Invalid guess. Enter a number between 1 and 100: 50
Your guess is too low

You have 6 guesses remaining.
Enter a number between 1 and 100: 75
Your guess is too low

You have 5 guesses remaining.
Enter a number between 1 and 100: 85
Your guess is too high

You have 4 guesses remaining.
Enter a number between 1 and 100: 0
Invalid guess. Enter a number between 1 and 100: 80

You have 3 guesses remaining.
Enter a number between 1 and 100: 81
You win!

game.play

You have 7 guesses remaining.
Enter a number between 1 and 100: 50
Your guess is too high

You have 6 guesses remaining.
Enter a number between 1 and 100: 25
Your guess is too low

You have 5 guesses remaining.
Enter a number between 1 and 100: 37
Your guess is too high

You have 4 guesses remaining.
Enter a number between 1 and 100: 31
Your guess is too low

You have 3 guesses remaining.
Enter a number between 1 and 100: 34
Your guess is too high

You have 2 guesses remaining.
Enter a number between 1 and 100: 32
Your guess is too low

You have 1 guesses remaining.
Enter a number between 1 and 100: 32
Your guess is too low
You are out of guesses. You lose.

Note that a game object should start a new game with a new number to
guess with each call to #play.
=end

class GuessingGame
  MAX_NO_GUESS = 7
  RANGE = 1..100

  attr_accessor :no_guesses, :guess, :result, :secret_number

  def initialize
    # not necessary here, but good practice. It provides a single location
    # where you can see all your instance variables.
    @no_guesses = MAX_NO_GUESS
    @secret_number = rand(1..100)
    @guess = nil
    @result = nil
  end

  def play
    reset
    loop do
      display_guesses_remaining
      ask_for_no
      evaluate_guess
      break if won?
      decrease_remaining_guesses
      display_result
      break if out_of_guesses?
    end
    puts "You win!" if won?
  end

  private

  def display_guesses_remaining
    puts "You have #{no_guesses} guesses remaining."
  end

  def ask_for_no
    answer = nil
    loop do
      print "Enter a number between 1 and 100: "
      answer = gets.chomp.to_i
      break if (RANGE).cover?(answer)
      puts "Sorry, that is not a valid number"
    end
    self.guess = answer
  end

  def evaluate_guess
    self.result = if guess > secret_number
                    "Your guess is too high"
                  elsif guess < secret_number
                    "Your guess is too low"
                  end
  end

  def decrease_remaining_guesses
    self.no_guesses -= 1
  end

  def display_result
    puts "#{result}"
    puts "You are out of guesses. You lose." if out_of_guesses?
  end

  def out_of_guesses?
    no_guesses == 0
  end

  def won?
    guess == secret_number
  end

  def reset
    @no_guesses = MAX_NO_GUESS
    @secret_number = rand(1..100)
    @guess = nil
    @result = nil
  end
end

game = GuessingGame.new
game.play
puts '-------------'
puts "new game"
puts '-------------'
game.play
