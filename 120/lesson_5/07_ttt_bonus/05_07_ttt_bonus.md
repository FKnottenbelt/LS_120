# OO TTT Bonus Features

Review the "bonus" features from the procedural TTT program, and
incorporate all of them here, in the OO version:

## Bonus" features from the procedural TTT program
### 1 - Improved "join"
If we run the current game, we'll see the following prompt:

=> Choose a position to place a piece: 1, 2, 3, 4, 5, 6, 7, 8, 9

This is ok, but we'd like for this message to read a little better.
We want to separate the last item with a "or", so that it reads:

=> Choose a position to place a piece: 1, 2, 3, 4, 5, 6, 7, 8, or 9

Currently, we're using the Array#join method, which can only insert
a delimiter between the array elements, and isn't smart enough to
display a joining word for the last element.

Write a method called joinor that will produce the following result:
```
joinor([1, 2])                   # => "1 or 2"
joinor([1, 2, 3])                # => "1, 2, or 3"
joinor([1, 2, 3], '; ')          # => "1; 2; or 3"
joinor([1, 2, 3], ', ', 'and')   # => "1, 2, and 3"
```
Then, use this method in the TTT game when prompting the user to
mark a square.

##### possible solution:
```ruby
def joinor(arr, delimiter=', ', word='or')
  case arr.size
  when 0 then ''
  when 1 then arr.first
  when 2 then arr.join(" #{word} ")
  else
    arr[-1] = "#{word} #{arr.last}"
    arr.join(delimiter)
  end
end
```
Using a case statement works well here because we need to perform
different actions based on the number of elements in arr. If arr
has 2 elements, then a delimiter isn't required and we can just
print the 2 elements, separated by the value of word. If arr has
more than 2 elements, then we permanently mutate the last element
with arr[-1] = and prepend the value of word. After we've modified
the last array element, we can just use Array#join to join the
elements.

Then, you could use it in the game like this:
```ruby
prompt "Choose a position to place a piece:
#{joinor(empty_squares(brd), ', ')}"
```
### 2- Keep score
Keep score of how many times the player and computer each win.
Don't use global or constant variables. Make it so that the first
player to 5 wins the game.

### 3- Computer AI: Defense
The computer currently picks a square at random. That's not very
interesting. Let's make the computer defensive minded, so that if
there's an immediate threat, then it will defend the 3rd square. We'll
consider an "immediate threat" to be 2 squares marked by the opponent
in a row. If there's no immediate threat, then it will just pick a
random square.

##### possible solution:
As usual, we'll take the most obvious, non-clever approach first. In
order to see if the player is about to win, we want to iterate through
our WINNING_LINES and see if any of them are at risk of being filled;
in other words, we can iterate through the WINNING_LINES and look fo
r any lines that have 2 of their values marked by the player.

Since our WINNING_LINES is an array of 3-element arrays, we can
iterate through WINNING_LINES and pass in each element (again, which
are 3-element arrays) into a method to see if any of those lines are
at risk of being filled. That means we need a method to inspect the
3-element array and tell us if 2 of those elements are marked by the
player.

Here's a stab.
```ruby
def find_at_risk_square(line, board)
  if board.values_at(*line).count('X') == 2
    board.select{|k,v| line.include?(k) && v == ' '}.keys.first
  else
    nil
  end
end
```
The trick to this code is the line:
`board.select{|k,v| line.include?(k) && v == ' '}.keys.first`. See if
you can use binding.pry to take that line apart and see what it's
doing.

Another interesting part of this code is the use of the splat operator
(*) on line. The splat operator essentially "explodes" the line array
into a comma-separated list. We have to use the splat operator because
the values_at method doesn't take an array, but does take a
comma-separated list of arguments. The splat operator does this
conversion for us.

Once you have defined the find_at_risk_square method, you can modify
the computer_places_piece! method like this:

```ruby
def computer_places_piece!(brd)
  square = nil
  WINNING_LINES.each do |line|
    square = find_at_risk_square(line, brd)
    break if square
  end

  if !square
    square = empty_squares(brd).sample
  end

  brd[square] = COMPUTER_MARKER
end
```
Finally, after we verify the find_at_risk_square method works, we
can use our constants:

```ruby
def find_at_risk_square(line, board)
  if board.values_at(*line).count(PLAYER_MARKER) == 2
    board.select{|k,v| line.include?(k) && v == INITIAL_MARKER}.keys.first
  else
    nil
  end
end
```

### 4- Computer AI: Offense
The defensive minded AI is pretty cool, but it's still not performing
as well as it could because if there are no impending threats, it
will pick a square at random. We'd like to make a slight improvement
on that. We're not going to add in any complicated algorithm (there's
an extra bonus below on that), but all we want to do is piggy back on
our find_at_risk_square from bonus #3 above and turn it into an
attacking mechanism as well. The logic is simple: if the computer
already has 2 in a row, then fill in the 3rd square, as opposed to
moving at random.

##### possible solution:
First, we'll make some slight modifications to find_at_risk_square.
We'll pass in the marker we're looking for, rather than hardcode
it to look for the player's marker.
```ruby
def find_at_risk_square(line, board, marker)
  if board.values_at(*line).count(marker) == 2
    board.select{|k,v| line.include?(k) && v == INITIAL_MARKER}.keys.first
  else
    nil
  end
end
```
Now that we're passing in the marker, we can use it for both defense
and offense. Only when there are no defensive or offensive moves
will the computer pick a random square.

```ruby
def computer_places_piece!(brd)
  square = nil

  # defense first
  WINNING_LINES.each do |line|
    square = find_at_risk_square(line, brd, PLAYER_MARKER)
    break if square
  end

  # offense
  if !square
    WINNING_LINES.each do |line|
      square = find_at_risk_square(line, brd, COMPUTER_MARKER)
      break if square
    end
  end

  # just pick a square
  if !square
    square = empty_squares(brd).sample
  end

  brd[square] = COMPUTER_MARKER
end
```

### 5- Computer turn refinements
a) We actually have the offense and defense steps backwards. In other
words, if the computer has a chance to win, it should take that move
rather than defend. As we have coded it now, it will defend first.
Update the code so that it plays the offensive move first.

b) We can make one more improvement: pick square #5 if it's available.
The AI for the computer should go like this: first, pick the winning
move; then, defend; then pick square #5; then pick a random square.

c) Can you change the game so that the computer moves first? Can you
make this a setting at the top (i.e. a constant), so that you could
play the game with either player or computer going first? Can you
make it so that if the constant is set to "choose", then your game
will prompt the user to determine who goes first? Valid options for
the constant can be "player", "computer", or "choose".


================
Allow the player to pick any marker.

Set a name for the player and computer.

