# OO TTT Bonus Features

## Bonus features from the procedural TTT program
- 1: create a joiner:

Write a method called joinor that will produce the following result:
```
joinor([1, 2])                   # => "1 or 2"
joinor([1, 2, 3])                # => "1, 2, or 3"
joinor([1, 2, 3], '; ')          # => "1; 2; or 3"
joinor([1, 2, 3], ', ', 'and')   # => "1, 2, and 3"
```
Then, use this method in the TTT game when prompting the user to
mark a square.

- 2: Keep score
- 3: Computer AI: Defense

  If there's an immediate threat, then the computer will defend the 3rd square.
  We'll consider an "immediate threat" to be 2 squares marked by the opponent
  in a row

- 4: Computer AI: Offense

  if the computer already has 2 in a row, then fill in the 3rd square, as
  opposed to moving at random.

- 5: Computer turn refinements

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

- 6: Improve the game loop

  Notice how we have to break after each player makes a move. What
  if we could have a generic method that marks a square based on the
  player? (use something like current_player)

## New for OO version:
- Allow the player to pick any marker.
- Set a name for the player and computer.