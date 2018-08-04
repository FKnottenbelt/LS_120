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

### Step 8 - Refactor detect_winner
use the 'write it in methods you wished exsisted' method to
refactor messy code

*detect_winner*

detect winner needs to return an marker or nil

lines is an array like [1,2,3]
we want to select those square objects (in an array) that have a
key that is the same as the ones in the line array
```
selection = @squares.select{ |k,_| line.include?(k) }.values
```
since @squares is an hash we can call .values_at on it
```
@squares.values_at(1)
=> [#<Square:0x00000002bc6f90 @marker=" ">]

@squares.values_at(1, 2, 3)
=> [#<Square:0x00000002bc6f90 @marker=" ">,
 #<Square:0x00000002bc6f68 @marker=" ">,
 #<Square:0x00000002bc6f40 @marker=" ">]
```

we can than use the splat operator to turn our line array
in a parameter list ( [1,2,3] to (1,2,3) ) by doing
*line
```
@squares.values_at(*line)
=> [#<Square:0x00000002bc6f90 @marker=" ">,
 #<Square:0x00000002bc6f68 @marker=" ">,
 #<Square:0x00000002bc6f40 @marker=" ">]
```
we now have an array of Square objects that are on the first line
to pass to the count method, which will see if there are 3
marks in the line.

*count_human_marker(squares)*

we are calling .marker on each of the square objects (&:marker)

`(&:marker)` does:
squares.map { |sqr| sqr.marker }
so `squares.map(&:marker)` gives: `["X", "O", "X"]`
and adding count gives how many X'es:
`squares.map(&:marker).count(TTTGame::HUMAN_MARKER`) gives `2`

### Step 9 - Play again
At about 08:12 into this video, the instructor enters a
system 'clear' statement after display_welcome_message. The
order of these two statements should be reversed: the
system 'clear' should come first.
