=begin
Using initialize in a module is possible: but as expected not because
the module runs initialize. However, if the class that includes the
module does not have an initialize itself, if will find the first
initialize in the method lookup path. Which might (or might not) be the
method in your module. All lookup rules apply, so if you mix in more
than one module the init the last one will run.
=end

module Hand
  attr_accessor :cards

  def initialize
    @cards = []
    @teller = 0
  end

  def to_s
    puts @cards
  end

  def add_card
    @teller += 1
    @cards << @teller
  end
end

module Speak
  def initialize
    puts "Hello!"
  end
end

class Player
  include Speak
  include Hand

  attr_reader :name

  # def initialize
  #   @name = 'bob'
  # end

end

bob = Player.new
bob.add_card
bob.add_card

p bob.cards
p bob.name