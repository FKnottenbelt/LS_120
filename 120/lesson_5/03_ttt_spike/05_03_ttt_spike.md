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
note: work from the play method one step at a time, just
enough to get that method working.

### Step 1 - Display a board
make your square 5 spaces wide and 3 high
move your X onto 3rd space

### Step 2 - Setup Board and Square classes
fill in your hash ( { 1 => Square.new(' '), etc} )
by being lazy:
   @squares = {}
  (1..9).each { |key| @squares[key] = Square.new(INITIAL_MARKER) }

### Step 3 - Human moves
use break and commenting out the not yet build methods to
move through your programm under construction

### Step 4 - Computer moves.

### Step 5 - Take turns
refactor as you go

### Step 6 - Break when board is full
have every thing, like your messages, reflect the current
state of the game.
(display results now just gives the display board and the message
that the board is full.)

### Step 7 - Detect winner

Step 8 - Refactor detect_winner
Step 9 - Play again
At about 08:12 into this video, the instructor enters a
system 'clear' statement after display_welcome_message. The
order of these two statements should be reversed: the
system 'clear' should come first.