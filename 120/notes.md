## Approach to OOP

The classical approach to object oriented programming is:

1 - Write a textual description of the problem or exercise.
   ```
   example
   Rock, Paper, Scissors is a two-player game where each player chooses
   one of three possible moves: rock, paper, or scissors. The chosen moves
   will then be compared to see who wins, according to the following rules:

   - rock beats scissors
   - scissors beats paper
   - paper beats rock

   If the players chose the same move, then it's a tie.
   ```
2 - Write the game flow

   ```
   example:
   The game flow should go like this:

   - the user makes a choice
   - the computer makes a choice
   - the winner is displayed
   ```
3 - Extract the major nouns and verbs from the description.
  ```
  example:
  Nouns: player, move, rule
  Verbs: choose, compare
  ```
4 - Organize and associate the verbs with the nouns.
  ```
  example:
  Player
   - choose
  Move
  Rule

  - compare
  ```
5 - The nouns are the classes and the verbs are the behaviors
    or methods.
    Start coding thing up (just sketch outline)

6 - Implement first feature

7 - Refactor
    So far:

    - hidden subclass antipattern

    - find collaborator object by looking at > and < statements
      (implementing both sides as values in new class that has
      < and > methods to compare them.)
  ```ruby
  #example:
      if human.move > computer.move
        puts "#{human.name} won!"
      elsif human.move < computer.move
        puts "#{computer.name} won!"
      else
        puts "It's a tie!"
      end

   # move is collaborator object to players.

  def <(other_move)
    if rock?
      return true if other_move.paper?
      return false
    elsif scissors?
      return true if other_move.rock?
      return false
    elsif paper?
      return true if other_move.scissors?
      return false
    end
  end
  ```
8 - repeat step 6 and 7



The biggest take away from the two design refactorings is that
when it comes to object oriented design, we're always juggling
a tradeoff between more flexible code and indirection. Put another
way, the more flexible your code, the more indirection you'll
introduce by way of more classes. There's likely an optimal
tradeoff on that spectrum for your application somewhere, but
that place likely changes as your application matures. This is
the source of never-ending debate and discussion in the software
development field, but it really comes down to that tradeoff.
This is where the "art" of programming comes in.