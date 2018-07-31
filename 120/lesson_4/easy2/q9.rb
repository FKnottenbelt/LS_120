=begin
If we have this class:

class Game
  def play
    "Start the game!"
  end
end

class Bingo < Game
  def rules_of_play
    #rules of play
  end
end

What would happen if we added a play method to the Bingo class, keeping
in mind that there is already a method of this name in the Game class that
the Bingo class inherits from.
=end

class Game
  def play
    "Start the game!"
  end
end

class Bingo < Game
  def rules_of_play
    #rules of play
  end

  def play
    "Start the Bingo game!"
  end

end

# it overules the one in Game:
game1 = Bingo.new
p game1.play