class Board
  def initialize
  end
end

class Square
  def initialize
  end
end

class Player
  def initialize
  end

  def mark
  end
end

class TTTGame
  def display_welcome_message
    puts "Welcome to Tic Tac Toe"
    puts
  end

  def display_goodbye_message
    puts "Thank you for playing Tic Tac Toe! Goodbye!"
  end

  # rubocop: disable Metrics/AbcSize
  def display_board(brd)
#    clear_screen
#    puts "You are a #{PLAYER_MARKER}. Computer is #{COMPUTER_MARKER}."
    puts ""
    puts "     |     |"
#    puts "  #{brd[1]}  |  #{brd[2]}  |  #{brd[3]}"
    puts "     |     |"
    puts "-----+-----+-----"
    puts "     |     |"
#    puts "  #{brd[4]}  |  #{brd[5]}  |  #{brd[6]}"
    puts "     |     |"
    puts "-----+-----+-----"
    puts "     |     |"
#    puts "  #{brd[7]}  |  #{brd[8]}  |  #{brd[9]}"
    puts "     |     |"
    puts ""
  end
  # rubocop: enable Metrics/AbcSize

  def play
    display_welcome_message
    loop do
      display_board('a')
      break
      first_player_moves
      break if someone_won? || board_full?

      second_player_moves
      break if someone_won? || board_full?
    end
#    display_result
    display_goodbye_message
  end
end

game = TTTGame.new
game.play
