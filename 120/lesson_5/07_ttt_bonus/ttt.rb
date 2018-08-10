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

  def joiner(arr, delimiter=', ', word='or')
    arr << arr.pop(2).join(' ' + word + ' ')
    arr.join(delimiter)
  end
end

class Board
  WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] + # rows
                  [[1, 4, 7], [2, 5, 8], [3, 6, 9]] + # cols
                  [[1, 5, 9], [3, 5, 7]]              # diagonals

  def initialize
    @squares = {}
    reset
  end

  def []=(num, marker)
    @squares[num].marker = marker
  end

  def unmarked_keys
    @squares.keys.select { |key| @squares[key].unmarked? }
  end

  def full?
    unmarked_keys.empty?
  end

  def someone_won?
    !!winning_marker
  end

  def winning_marker
    WINNING_LINES.each do |line|
      squares = @squares.values_at(*line)
      if identical_markers?(squares, 3)
        return squares.first.marker
      end
    end
    nil
  end

  def empty_square(line)
    line.each do |position|
      return position if unmarked_keys.include?(position)
    end
    nil
  end

  def winning_move(player_marker)
    squares = find_at_risk_squares
    return nil if !squares
    squares.keys.include?(player_marker) ? squares[player_marker] : nil
  end

  def blocking_move(other_player_marker)
    squares = find_at_risk_squares
    return nil if !squares
    return squares[other_player_marker] if
      squares.keys.include?(other_player_marker)
    nil
  end

  def middle_square
    middle_square = 5
    unmarked_keys.include?(middle_square) ? middle_square : nil
  end

  def reset
    (1..9).each { |key| @squares[key] = Square.new }
  end

  # rubocop:disable Metrics/AbcSize
  def draw
    puts "     |     |"
    puts "  #{@squares[1]}  |  #{@squares[2]}  |  #{@squares[3]}"
    puts "     |     |"
    puts "-----+-----+-----"
    puts "     |     |"
    puts "  #{@squares[4]}  |  #{@squares[5]}  |  #{@squares[6]}"
    puts "     |     |"
    puts "-----+-----+-----"
    puts "     |     |"
    puts "  #{@squares[7]}  |  #{@squares[8]}  |  #{@squares[9]}"
    puts "     |     |"
  end
  # rubocop:enable Metrics/AbcSize

  private

  def identical_markers?(squares, num_identical)
    markers = squares.select(&:marked?).collect(&:marker)
    return false if markers.size != num_identical
    markers.min == markers.max
  end

  def find_at_risk_squares
    at_risk_squares = {}

    WINNING_LINES.each do |line|
      squares = @squares.values_at(*line)
      marked_as = squares.select(&:marked?).map(&:marker).first

      if identical_markers?(squares, 2)
        at_risk_squares[marked_as] = empty_square(line)
      end
    end

    at_risk_squares.empty? ? nil : at_risk_squares
  end
end

class Square
  INITIAL_MARKER = " "

  attr_accessor :marker

  def initialize(marker=INITIAL_MARKER)
    @marker = marker
  end

  def to_s
    @marker
  end

  def unmarked?
    marker == INITIAL_MARKER
  end

  def marked?
    marker != INITIAL_MARKER
  end
end

class Player
  attr_reader :marker, :name
end

class Human < Player
  def initialize
    @name = set_name
    @marker = choose_marker
  end

  private

  def choose_marker
    answer = nil
    print "Hello #{name}, "
    loop do
      puts "What marker would you like?"
      answer = gets.chomp
      break unless answer == ' ' || answer.size <= 0
      puts "Sorry, that is not a valid answer."
    end
    answer
  end

  def set_name
    answer = nil
    loop do
      puts "What is your name?"
      answer = gets.chomp
      break unless answer == ' ' || answer.size <= 0
      puts "Sorry, that is not a valid answer."
    end
    answer
  end
end

class Computer < Player
  def initialize(other_marker)
    @marker = determine_marker(other_marker)
    @name = set_name
  end

  private

  def determine_marker(other_marker)
    other_marker == 'O' ? 'X' : 'O'
  end

  def set_name
    ['Hal', 'Chappie', 'Sonny', 'Number 5'].sample
  end
end

class TTTGame
  FIRST_TO_MOVE = 'player' # "player", "computer", or "choose"
  WINNING_SCORE = 2

  include Gameable

  attr_reader :board, :human, :computer, :score, :game_winner

  def initialize
    clear_screen
    display_welcome_message
    @board = Board.new
    @human = Human.new
    @computer = Computer.new(human.marker)
    @current_marker = first_to_move
    @score = { human: 0, computer: 0 }
    @game_winner = nil
  end

  def play
    clear_screen
    display_lets_play

    loop do
      display_board
      play_round
      display_result
      break unless play_again?
      reset
      display_play_again_message
    end
    display_goodbye_message
  end

  private

  def display_welcome_message
    puts "Welcome to Tic Tac Toe!"
    puts "First one to win #{WINNING_SCORE} games wins the match!"
    puts ""
  end

  def display_lets_play
    puts "Okay #{human.name}, let's play!"
  end

  def display_goodbye_message
    puts "Thanks for playing Tic Tac Toe! Goodbye!"
  end

  def clear_screen_and_display_board
    clear_screen
    display_board
  end

  def display_board
    puts "You're a #{human.marker}. #{computer.name} is a #{computer.marker}."
    puts ""
    board.draw
    puts ""
  end

  def human_moves
    puts "Choose a square (#{joiner(board.unmarked_keys)}): "
    square = nil
    loop do
      square = gets.chomp.to_i
      break if board.unmarked_keys.include?(square)
      puts "Sorry, that's not a valid choice."
    end

    board[square] = human.marker
  end

  def computer_moves
    square = board.winning_move(computer.marker) ||
             board.blocking_move(human.marker) ||
             board.middle_square ||
             board.unmarked_keys.sample
    board[square] = computer.marker
  end

  def current_player_moves
    if @current_marker == human.marker
      human_moves
      @current_marker = computer.marker
    else
      computer_moves
      @current_marker = human.marker
    end
  end

  def update_score
    if board.winning_marker == human.marker
      score[:human] += 1
    elsif board.winning_marker == computer.marker
      score[:computer] += 1
    end
  end

  def display_score
    puts "The score is: You #{score[:human]} -" \
      " #{computer.name} #{score[:computer]}"
  end

  def declare_game_winner
    @game_winner = 'human' if score[:human] == WINNING_SCORE
    @game_winner = 'computer' if score[:computer] == WINNING_SCORE
  end

  def display_result
    clear_screen_and_display_board
    display_score

    case board.winning_marker
    when human.marker
      puts "You won!"
    when computer.marker
      puts "Computer won!"
    else
      puts "It's a tie!"
    end
  end

  def reset
    board.reset
    @current_marker = first_to_move
    @score = { human: 0, computer: 0 }
    @game_winner = nil
    clear_screen
  end

  def display_play_again_message
    puts "Let's play again!"
    puts ""
  end

  def play_turn
    loop do
      current_player_moves
      break if board.someone_won? || board.full?
      clear_screen_and_display_board
    end
  end

  def reset_round
    board.reset
    @current_marker = first_to_move
  end

  def display_next_round_message
    puts "Next round!"
    puts
  end

  def play_round
    loop do
      play_turn
      update_score
      declare_game_winner
      break if game_winner
      clear_screen_and_display_board
      display_score
      display_next_round_message
      reset_round
      display_board
    end
    clear_screen_and_display_board
    display_result
  end

  def who_goes_first
    answer = nil
    loop do
      puts "Who should play first, you or the computer? (m/c)"
      answer = gets.chomp.downcase
      break if %w[m c].include?(answer)
      puts "Sorry, that is not a valid answer. Choose m (for me) or c" \
        " (for computer)"
    end

    answer == 'm' ? human.marker : computer.marker
  end

  def first_to_move
    case FIRST_TO_MOVE
    when 'choose'
      who_goes_first
    when 'player'
      human.marker
    when 'computer'
      computer.marker
    else
      human.marker
    end
  end
end

game = TTTGame.new
game.play
