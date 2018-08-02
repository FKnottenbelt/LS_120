# Assignment: OO Tic Tac Toe

In this assignment, we'll build a Tic Tac Toe game, just like the
one we built before. This game is a little bit more complicated
than Rock, Paper, Scissors, because there's the notion of a "game
state", which should represent the current state of the board (the
RPS game didn't have game state, only choices).

We'll take an object-oriented approach to designing the solution,
so we'll employ the steps we learned earlier:

- Write a description of the problem and extract major nouns and
  verbs.
- Make an initial guess at organizing the verbs into nouns and do
  a spike to explore the problem with temporary code.
- Optional - when you have a better idea of the problem, model
  your thoughts into CRC cards.

# Nouns and Verbs

Let's write a short description of the game.

Tic Tac Toe is a 2-player board game played on a 3x3 grid.
Players take turns marking a square. The first player to mark
3 squares in a row wins.

On the surface, Tic Tac Toe is a very simple game, without too
many nouns:

Nouns: board, player, square, grid
Verbs: play, mark

Let's now organize it a bit:

Board
Square
Player
- mark
- play

The "grid" noun was omitted because it's the same as a "board".
There doesn't appear to be any verbs for "Board" or "Square",
making the organization of verbs and nouns seem really awkward.
Recall that we ran into a similar thing when first starting out
the Rock, Paper, Scissors program.

Remember, though, that this exercise only serves as a starting
point for us to "spike", or explore.
