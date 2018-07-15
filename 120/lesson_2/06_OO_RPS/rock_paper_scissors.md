# Assignment: OO Rock Paper Scissors

In this assignment, we'll build a Rock, Paper, Scissors game.
The game flow should go like this:

   - the user makes a choice
   - the computer makes a choice
   - the winner is displayed

## Approach to OOP

The classical approach to object oriented programming is:

1 - Write a textual description of the problem or exercise.
2 - Extract the major nouns and verbs from the description.
3 - Organize and associate the verbs with the nouns.
4 - The nouns are the classes and the verbs are the behaviors
    or methods.

Notice that in OO, we don't think about the game flow logic at
all. It's all about organizing and modularizing the code into
a cohesive structure - classes. After we come up with the initial
class definitions, the final step is to orchestrate the flow of the
program using objects instantiated from the classes. We won't worry
about that final step yet.

Let's use the above approach and first write out a textual
description of Rock, Paper and Scissors.

## 1- Textual description of Rock, Paper and Scissors

Rock, Paper, Scissors is a two-player game where each player chooses
one of three possible moves: rock, paper, or scissors. The chosen moves
will then be compared to see who wins, according to the following rules:

- rock beats scissors
- scissors beats paper
- paper beats rock

If the players chose the same move, then it's a tie.

## 2 - Extract the major nouns and verbs from the description.

Let's now look at the above description, and try to extract the
major nouns and verbs. In a way, Rock, Paper, Scissors is a
difficult game to code in OO style, because there aren't many
obvious nouns. The problem domain is easier to model and extract
to classes when there are real world nouns that match the problem
description. However, in RPS, the nouns are more subtle. Nevertheless,
let's give it a shot.
```
Nouns: player, move, rule
Verbs: choose, compare
```

Note that we decided to ignore "rock", "paper" or "scissors", since
they are all variations on a move -- almost like different states
of a move. Therefore, we capture the major noun: move.

## 3 - Organize and associate the verbs with the nouns.

Now for step 3: organizing the verbs with the nouns. One would think
that given the few nouns and verbs we're working with, this would
be a very easy exercise. However, it's not obvious where the "compare"
verb goes. Here's a list of the nouns and their verbs.
```
Player
 - choose
Move
Rule

- compare
```

Notice that a "Player" can "choose", but "Move" and "Rule" don't
have any verbs at all, and we aren't sure where to put "compare".
This is an awkward first attempt, but it's all we are comfortable
assuming at this point. We'll have to take a stab at defining our
classes with this.

## 4 - The nouns are the classes and the verbs are the behaviors or methods.
Let's code up some classes and methods. While we do this, we can
also think about what "states" the objects of these classes should
have.

```ruby
class Player
  def initialize
    # maybe a "name"? what about a "move"?
  end

  def choose

  end
end

class Move
  def initialize
    # seems like we need something to keep track
    # of the choice... a move object can be "paper", "rock" or "scissors"
  end
end

class Rule
  def initialize
    # not sure what the "state" of a rule object should be
  end
end

# not sure where "compare" goes yet
def compare(move1, move2)

end
```
We won't fill out the exact details yet, but these are the initial
skeleton classes and methods we're going to start with. This is
the initial rough napkin modeling of the problem. Notice that
there are lots of unanswered questions at this point.

# Orchestration Engine

After we're done organizing nouns and verbs into classes, we need
an "engine" of some sort to orchestrate the objects. This is where
the procedural program flow should be. Let's call the "engine"
class RPSGame. We want an easy interface to kick things off, so
perhaps to play the game, we just instantiate an object and call
a method called play, like this:

```ruby
RPSGame.new.play
```
Given that interface, we can start to take a stab at the class
definition.
```ruby
class RPSGame
  def initialize

  end

  def play

  end
end
```

Starting from that skeleton, we can start to think about what
objects are required in the play method to facilitate the game.

```ruby
def play
  display_welcome_message
  human_choose_move
  computer_choose_move
  display_winner
  display_goodbye_message
end
```

Lines 3 and 4 look similar, and it also looks like there's a
redundant "choose_move" part. This ties into our Player class,
which has a choose method. What if "human" and "computer" were
both objects of the Player class? They'd both immediately have
the Player#choose method. With that insight, we update the RPSGame
class definition:

```ruby
class RPSGame
  attr_accessor :human, :computer

  def initialize
    @human = Player.new
    @computer = Player.new
  end

  def play
    display_welcome_message
    human.choose
    computer.choose
    display_winner
    display_goodbye_message
  end
end
```
The objects are starting to take shape. There's still the question
of how to use the Move class and the Rule class in our game. Or
maybe those classes aren't even needed at all?

We'll stop here for now and continue on with this initial
brainstorm in the next assignment.

In the next assignment, we'll continue on where we left off here
and go on an exploratory coding spree to better understand
the problem.