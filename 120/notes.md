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
8 - repeat step 6 and 7 and somewhere in there run rubocop
    and refactor some more.



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


# Coding tips

## Explore the problem before design.
It can be very difficult to come up with the "right" classes and
methods when you first approach a problem. Take time to explore
the problem domain with a spike - exploratory code to play around
with the problem. Spikes can help validate initial hunches and
hypotheses. You don't have to worry about code quality, because
the idea of a spike is to throw away the code. If you were writing
an essay, the spike would be the initial braindump of ideas. As you
start to understand the problem better and get a feel for possible
solutions, start to organize your code into coherent classes and
methods.

## Repetitive nouns in method names is a sign that you're missing a class.

In our Rock, Paper, Scissors game for example, if we find ourselves
constantly referring to a "move", it may be a sign that we should
encapsulate the logic into a Move class (which is what we did).
Suppose we had the following code and move is a string or integer
(ie, not a custom object):
```ruby
human.make_move
computer.make_move

puts "Human move was #{format_move(human.move)}."
puts "Computer move was #{format_move(computer.move)}."

if compare_moves(human.move, computer.move) > 1
  puts "Human won!"
elsif compare_moves(human.move, computer.move) < 1
  puts "Computer won!"
else
  puts "It's a tie!"
end
```
The above code is fabricated, but it's not as far fetched as
it seems. The format_move helper method formats the move in our
output, because we don't have an object that we can tell to
"format yourself for output". We also need a compare_moves
helper method because the moves don't know how to compare
themselves with each other. All these references to "move" gives
us a hint that we should be encapsulating the move into a custom
move object, so that we can tell the object to "format yourself"
or "compare yourself against another". Look at how the code could
be possibly improved:
```ruby
human.move!
computer.move!

puts "Human move was #{human.move.display}."
puts "Computer move was #{computer.move.display}."

if human.move > computer.move
  puts "Human won!"
elsif human.move < computer.move
  puts "Computer won!"
else
  puts "It's a tie!"
end
```
The logic that used to be in straggling helper methods are now
in the appropriate class: Move#display and the comparison methods
Move#< and Move#>.

## When naming methods, don't include the class name.

A lot of beginners will write methods like this:
```ruby
class Player
  def player_info
    # returns player's name, move and other data
  end
end
```
But the player_info method is poorly named. It's not always the
case, but most of the time, you can leave off the class name
in method definitions. Remember to always think about the
method's usage or interface when you define methods. Pick naming
conventions that are consistent, easy to remember, give an idea
of what the method does, and reads well at invocation time.

# Avoid long method invocation chains.
When working with object oriented code, it's tempting to keep
calling methods on collaborator objects. Take the following code.
```
human.move.display.size
```
This is a 3 chain method invocation, and is very fragile.
For example, if human.move returns nil, then the entire method
invocation chain blows up, and it's very hard to debug the error.
There are many solutions for this type of problem, and many
strategies are beyond what we want to talk about right now. For
now, develop the initial instinct to smell out code that contains
long method invocation chains, and try to think about the
possibility of nil or other unexpected return values in the middle
of the chain. If you've identified that human.move could possibly
return nil, for example, then you can put in some guard expressions
like this:
```ruby
move = human.move
puts move.display.size if move
```
There's no prescription for every scenario, but the goal for now
is to develop your instincts.
```
remember Demeters law?: "Only talk to your immediate neighbours
/ use ony one dot". If you find yourself breaking Demeter, go
back to a message based perspective to find a better public
interface
```

## Avoid design patterns for now.

One of the biggest mistakes beginner programmers make is mis-application
of "best practices" or "design patterns" to improve performance or
flexibility. This is such a common phenomenon that experienced
programmers have a quote: "premature optimization is the root of all evil".

Don't worry about optimization at this point. Don't write overly
clever code. Granted, you won't know what's considered "clever" vs
"normal" without reading a lot of code, but over time, you will start
to hone your senses.

You'll spend the rest of your career mastering design patterns and best
practices. Most importantly, you should spend time understanding when to
use those things.
