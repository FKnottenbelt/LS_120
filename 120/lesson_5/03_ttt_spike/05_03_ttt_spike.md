# Walk-through: OO TTT Spike

We're going to start the initial spike of the TTT game with the
following code from the previous assignment.

```ruby
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
  def play
    display_welcome_message
    loop do
      display_board
      first_player_moves
      break if someone_won? || board_full?

      second_player_moves
      break if someone_won? || board_full?
    end
    display_result
    display_goodbye_message
  end
end

game = TTTGame.new
game.play
```

Watch and type along with the below videos.

1 -
Walk-through: OO TTT Spike

We're going to start the initial spike of the TTT game with the following code from the previous assignment.

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
  def play
    display_welcome_message
    loop do
      display_board
      first_player_moves
      break if someone_won? || board_full?

      second_player_moves
      break if someone_won? || board_full?
    end
    display_result
    display_goodbye_message
  end
end

game = TTTGame.new
game.play

Watch and type along with the below videos.


Walk-through: OO TTT Spike

We're going to start the initial spike of the TTT game with the following code from the previous assignment.

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
  def play
    display_welcome_message
    loop do
      display_board
      first_player_moves
      break if someone_won? || board_full?

      second_player_moves
      break if someone_won? || board_full?
    end
    display_result
    display_goodbye_message
  end
end

game = TTTGame.new
game.play

Watch and type along with the below videos.


Walk-through: OO TTT Spike

We're going to start the initial spike of the TTT game with the following code from the previous assignment.

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
  def play
    display_welcome_message
    loop do
      display_board
      first_player_moves
      break if someone_won? || board_full?

      second_player_moves
      break if someone_won? || board_full?
    end
    display_result
    display_goodbye_message
  end
end

game = TTTGame.new
game.play

Watch and type along with the below videos.

Step 1 - Display a board
Step 2 - Setup Board and Square classes
Step 3 - Human moves
Step 4 - Computer moves
Step 5 - Take turns
Step 6 - Break when board is full
Step 7 - Detect winner
Step 8 - Refactor detect_winner
Step 9 - Play again