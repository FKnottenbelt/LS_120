=begin
In the previous exercise, you wrote a number guessing game that determines
a secret number between 1 and 100, and gives the user 7 opportunities to
guess the number.

Update your solution to accept a low and high value when you create a
GuessingGame object, and use those values to compute a secret number for
the game. You should also change the number of guesses allowed so the user
can always win if she uses a good strategy. You can compute the number of
guesses with:

Math.log2(size_of_range).to_i + 1

Examples:

game = GuessingGame.new(501, 1500)
game.play

You have 10 guesses remaining.
Enter a number between 501 and 1500: 104
Invalid guess. Enter a number between 501 and 1500: 1000
Your guess is too low

You have 9 guesses remaining.
Enter a number between 501 and 1500: 1250
Your guess is too low

You have 8 guesses remaining.
Enter a number between 501 and 1500: 1375
Your guess is too high

You have 7 guesses remaining.
Enter a number between 501 and 1500: 80
Invalid guess. Enter a number between 501 and 1500: 1312
Your guess is too low

You have 6 guesses remaining.
Enter a number between 501 and 1500: 1343
Your guess is too low

You have 5 guesses remaining.
Enter a number between 501 and 1500: 1359
Your guess is too high

You have 4 guesses remaining.
Enter a number between 501 and 1500: 1351
Your guess is too high

You have 3 guesses remaining.
Enter a number between 501 and 1500: 1355
You win!

game.play
You have 10 guesses remaining.
Enter a number between 501 and 1500: 1000
Your guess is too high

You have 9 guesses remaining.
Enter a number between 501 and 1500: 750
Your guess is too low

You have 8 guesses remaining.
Enter a number between 501 and 1500: 875
Your guess is too high

You have 7 guesses remaining.
Enter a number between 501 and 1500: 812
Your guess is too low

You have 6 guesses remaining.
Enter a number between 501 and 1500: 843
Your guess is too high

You have 5 guesses remaining.
Enter a number between 501 and 1500: 820
Your guess is too low

You have 4 guesses remaining.
Enter a number between 501 and 1500: 830
Your guess is too low

You have 3 guesses remaining.
Enter a number between 501 and 1500: 835
Your guess is too low

You have 2 guesses remaining.
Enter a number between 501 and 1500: 836
Your guess is too low

You have 1 guesses remaining.
Enter a number between 501 and 1500: 837
Your guess is too low

You are out of guesses. You lose.

Note that a game object should start a new game with a new number to
guess with each call to #play.
=end

class GuessingGame

  attr_accessor :no_guesses, :guess, :result, :secret_number
  attr_reader :range

  def initialize(lowest_value, highest_value)
    @range = (lowest_value..highest_value)
    @secret_number = rand(range)
    @no_guesses = max_no_of_guesses
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

  def max_no_of_guesses
    Math.log2(range.size).to_i + 1
  end

  def display_guesses_remaining
    puts "You have #{no_guesses} guesses remaining."
  end

  def ask_for_no
    answer = nil
    loop do
      print "Enter a number between #{range.first} and #{range.last}: "
      answer = gets.chomp.to_i
      break if (range).cover?(answer)
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
    @secret_number = rand(range)
    @no_guesses = max_no_of_guesses
    @guess = nil
    @result = nil
    #p "secret number is: #{@secret_number} " ## TESTING
  end
end

game = GuessingGame.new(1, 10)
game.play
puts '-------------'
puts "new game"
puts '-------------'
game.play
