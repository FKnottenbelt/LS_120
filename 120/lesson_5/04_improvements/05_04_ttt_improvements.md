# Assignment: Some Improvements

## 1 - clear screen method
While the code from our initial exploration seems to work, and the
classes we created seem agreeable, there are some areas in the code
that we should improve on before moving forward.

- We use system "clear" to clear the screen. Suppose we want to
  change this to some other command in the future - we'd have to
  change it in multiple places. Create a clear method and call this
  new method instead of system "clear".

##### possible solution:
```ruby
class TTTGame
  # ... rest of class omitted for brevity

  def clear
    system "clear"
  end
end
```
This method name, however, collides with the local variable in
display_board. Since the scope of the local variable is only within
the method, let's rename that.

```ruby
def display_board(clear_screen = true)
  clear if clear_screen

  # ... rest of method omitted for brevity
end
```

## 2 - display_board(clear_screen: false)
The first time we display a board, we want to suppress the clearing
of the screen. This is so we can see the welcome message, or the
play again message. However, the method invocation,
display_board(false) is incredibly vague. Six months from now,
no one will remember what that false stands for without looking
at the method implementation. Let's change the method so that we
can invoke it like this: display_board(clear_screen: false).

=> so we need to put in a hash with a key :clear_screen and a
value of true or false.
I know how to do that if screen is a class..

The trick is:
```ruby
display_board(clear_screen: false)

def display_board(options = { clear_screen: true })
    clear_screen if options[:clear_screen]
end
```

##### possible solution:
```ruby
def display_board(options = { clear_screen: true })
  clear if options[:clear_screen]

  # ... rest of method omitted for brevity
end
```

Note that when we invoke the method, we can do any of the
following:

method invocation |	effect
--|--
display_board | the options hash will be set to the default hash, {clear_screen: true}
display_board({clear_screen: false}) |	options will be replaced by the hash in the argument, {clear_screen: false}
display_board(clear_screen: false)|	same effect as above, despite the missing {}
display_board clear_screen: false |	same effect as above, despite the missing {} and missing ()
display_board(a: 1, b: 2) |	same effect as above, except the options hash will now be set to {a: 1, b: 2}. Surprisingly, this works for our method since we're just calling options[:clear_screen], which in this case will return nil (and be evaluated as false)

Now that we can call display_board(clear_screen: false), we stand
a much better chance at remembering what this method does in the
future. The code is almost self documenting.

## - 3 clear_screen_and_display_board.
Though an improvement, the necessity to even pass in a qualifier
to the display_board method points to a deeper problem. The method
doesn't take a large number of options; it just takes 1 option.
That option serves as a fork in the method: one fork clears the
screen, then displays the board, while the other fork just displays
the board. Let's create two methods: display_board and
clear_screen_and_display_board. The former only displays the
board, while the latter clears the screen first.

##### possible solution:
```ruby
def clear_screen_and_display_board
  clear
  display_board
end

def display_board
  # only code to display the board
end
```

We also have to replace all previous calls to display_board
with clear_screen_and_display_board. And finally, we have to
replace display_board(clear_screen: false) with our new
display_board.

Now, all the methods are named appropriately, and we can invoke
them without having to refer to their implementation. Even six
months from now.

## 4 - rename Board#detect_winner
Speaking of better names, let's take a look at our
Board#detect_winner method. The method name is ambiguous about
what this method does. Just looking at the name, we wouldn't
be surprised if it returned a Player object or a symbol. Let's
rename it to reflect what it does: winning_marker. This new name
reminds us that the method will return the winning marker, or
nil in the case of no winning marker. After you change the method
definition, don't forget to also update all method invocations.

## 5 - TTTGame#reset
Our TTTGame#play method reads very well. Most methods there are
declarative. That is, we are just giving high level commands,
like "display_board", "human_moves", and we're not focused on
the imperative step-by-step instructions of how to do those
things. Operating at this higher level of abstraction allows us
to orchestrate the sequence of actions and organize the game
flow much easier. However, we deviate a bit towards the end of
the method after play_again?.

For example, the below code after play_again? is very imperative
in nature
```ruby
def play
  # ... rest of method omitted for brevity

  break unless play_again?
  board.reset
  clear
  puts "Let's play again!"
  puts ""
end
```

We should extract it to a well-named method to keep the
TTTGame#play method at a declarative level. Let's move all of
that into a method called TTTGame#reset.

##### possible solution:
Implementing this method is as simple as copying pasting the
imperative part over to the new method.
```ruby
def reset
  board.reset
  clear
  puts "Let's play again!"
  puts ""
end
```

This definitely works, but the reset method feels like it's
doing a bit too much: it's affecting a change (resetting the
board), as well as printing out some output. Let's move the two
puts lines into another method.

```ruby
def reset
  board.reset
  clear
end

def display_play_again_message
  puts "Let's play again!"
  puts ""
end
```

Now, if we invoke the above two methods, our TTTGame#play method
reads very fluidly. It's almost like reading natural English.

```ruby
def play
  clear
  display_welcome_message

  loop do
    display_board

    loop do
      human_moves
      break if board.someone_won? || board.full?

      computer_moves
      break if board.someone_won? || board.full?

      clear_screen_and_display_board
    end
    display_result
    break unless play_again?
    reset
    display_play_again_message
  end

  display_goodbye_message
end
```
## 6 - Board#draw
As we glance down the list of methods, it's surprising that
we display the board in the TTTGame class. That seems like a
responsibility of the Board class. We should be able to tell
the board to "display yourself". Let's move the logic from
display_board to Board#draw. We'll still keep the
TTTGame#display_board method, though, because the TTTGame
needs to tweak the output a little (eg, the marker prompt
at the top, and the padding.)

##### possible solution:
```ruby
class Board
  # ... rest of class omitted for brevity

  def draw
    puts "     |     |"
    puts "  #{get_square_at(1)}  |  #{get_square_at(2)}  |  #{get_square_at(3)}"
    puts "     |     |"
    puts "-----+-----+-----"
    puts "     |     |"
    puts "  #{get_square_at(4)}  |  #{get_square_at(5)}  |  #{get_square_at(6)}"
    puts "     |     |"
    puts "-----+-----+-----"
    puts "     |     |"
    puts "  #{get_square_at(7)}  |  #{get_square_at(8)}  |  #{get_square_at(9)}"
    puts "     |     |"
  end
end
```
Notice that the Board#draw method above won't contain any of the
extra messages. Instead, we'll leave that in the original
TTTGame#display_board method, which is below.

```ruby
class TTTGame
  # ... rest of class omitted for brevity

  def display_board
    puts "You're a #{human.marker}. Computer is a #{computer.marker}."
    puts ""
    board.draw
    puts ""
  end
end
```

Now, the TTTGame#display_board just calls Board#draw. Why did we
only move the board output to the Board#draw method, and not the
extra information about the player and computer marker, and the
extra puts "" before and after the display of the board? The answer
has to do with organizing the code.

Board#draw shouldn't know anything about player markers or extra
padding. It should only be concerned with one thing: drawing the
state of the board. You can almost think of this as the board's
to_s method. It should be generic so that it can be used in a
variety of yet unanticipated situations.

TTTGame#display_board is where we're organizing all concerns
related to presentation of the board in the Tic Tac Toe game
flow. It's here that we know exactly what extra information we
want in the context of a game.

## 7 - calling @squares directly
After the changes in the previous step, we are now calling
Board#get_square_at from the Board#draw method. Since Board#draw
is an instance method, it has access to the @squares hash directly.
Should Board#draw use get_square_at or interrogate @squares
directly?

##### possible solution:
There's no definite rule for this, but if your class has getter
and setter methods, you should probably use them. There are times
to avoid the getter/setter methods, such as when those methods do
some pre or post processing, and you wish to only work with the
raw data in the instance variable.

If your objects do not need to expose their internal instance
variables to the outside, then you don't need getter or setter
methods at all. In those situations, you can also access the
instance variables directly. Note: this is only talking about
referencing instance variables in the same class; this is not
talking about reaching into an object from the outside and
accessing or modifying its instance variables.

In our situation, we no longer need the Board#get_square_at
method at all, since the only place we used it was rendering
of the board. Now that the board rendering code has been moved
to Board#draw, we can remove the Board#get_square_at method
altogether; there's no need for that method anymore.

This implies that we can reference the @squares instance variable
directly from Board#draw.
```ruby
class Board
  # ... rest of class omitted for brevity

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
end
```

## 8 - Board#[]=
Though we no longer need the Board#get_square_at method, we still
need the Board#set_square_at method. This is the method that gets
invoked when either the human or the computer makes their move.
The method, though, is a little clunky. Let's make it more
idiomatic Ruby. Instead of calling this:
`board.set_square_at(square, human.marker)`, let's update the board
like this: `board[square] = human.marker`. That reads a lot better.

##### possible solution:
Recall from the "Fake Operators" assignment that we can facilitate
the desired syntax by creating a Board#[]= method.

```ruby
class Board
  # ... rest of class omitted for brevity

   def []=(num, marker)
    @squares[num].marker = marker
  end
end
```

Ruby sees the []= method and allows us to invoke it with a special
syntax that resembles assignment. The result is code that reads
more more fluidly (but more confusing for the beginner).

We can now delete Board#set_squares_at, and change all its
invocations with Board#[]=.

so `board.set_square_at(square, human.marker)` becomes
`board[square] = human.marker`
and `board.set_square_at(board.unmarked_keys.sample,`
`computer.marker)` becomes `board[board.unmarked_keys.sample]`
`= computer.marker`
so: board[num]=marker

Note that if we ever need a getter method for the marker of a
square, we can create a Board#[] method, which reads better than
our old Board#get_square_at.

## 9 - decoupling Board#winning_marker
The next improvement we'll make is related to our most complicated
method: Board#winning_marker. The problem with this method is
that it relies on knowledge of both the human and computer markers.
This doesn't feel quite right. Why does the Board class have to
know about specific markers in the TTTGame class? A board object
contains the state of the board. It's responsible for knowing
things related to a board: whether all squares are marked, how
to draw itself, how many empty squares are left, and whether a
marker has won. The goal of Board#winning_marker is to return
some winning marker or nil, but in our implementation, we hardcoded
the human and computer markers. This board's implementation is tied
to the implementation of TTTGame class. But in this case, that's
not necessary. We should change the implementation of
Board#winning_marker to see if any marker, not just the human or
computer's, has won. If so, return that marker, and if not, return
nil.

##### possible solution:
First, we'll need to create a Square#marked method (it's not
mandatory, but will help us write more concise code).

```ruby
class Square
 # ... rest of class omitted for brevity

  def marked?
    marker != INITIAL_MARKER
  end
end
```

In our Board#winning_marker method, we can call the method we
wished existed.

```ruby
def winning_marker
  WINNING_LINES.each do |line|
    squares = @squares.values_at(*line)
    if three_identical_markers?(squares) # => we wish this method existed
      return squares.first.marker        # => return the marker, whatever it is
    end
  end
  nil
end
```

Finally, we can implement the desired method.
```ruby
def three_identical_markers?(squares)
  markers = squares.select(&:marked?).collect(&:marker)
  return false if markers.size != 3
  markers.min == markers.max
end
```
Let's walk through the above three lines.

The first line is dense. First, we select only the marked squares,
using the newly created Square#marked? method. Next, we transform
that array of marked squares into an array of markers, or strings.
The array of strings is assigned to the markers variable.

The second line is a guard. We can return false if there aren't
three marked squares, because winning means 3 marked squares in
a row.

By the time we get to the third line, we know that we have a
3-item array of strings. Now we just need to tell if these 3
strings are the same. We're relying on Array#max and Array#min
here. Given an array of strings, Array#max will return the string
that starts with the letter closest to 'Z'. Array#min, however,
will return the string that starts with the letter closest to 'A'.
Therefore, if both of those methods return the same value, then
all elements in the markers array are identical.

There are lots of ways to determine if all elements in an array
contains the same value, so we just picked one that looked
cleanest. You could loop, of course. You could also do
markers.uniq.size == 1. This relies on the fact that Array#uniq
removes duplicate entries, so if there's only 1 element left,
then all elements were the same.

Finally, let's move the three_identical_markers? method to a
private method, since it's not being invoked from outside the
class.

After implementing these changes, we can now also delete
Board#count_human_marker and Board#count_computer_marker since
they are no longer being used. Note that despite the dramatic
update, we did not change the input or return values of the
method at all, thereby saving us from having to make any
changes to methods that rely on winning_marker, such as
someone_won?. Our Board class now feels much cleaner and more
general purpose. It's aware of generic board-related behaviors
, and can return the winning marker, without mind to which
exact marker it is.
