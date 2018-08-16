# closer look at the monkey patch in Poker

class Deck
  RANKS = (2..10).to_a + %w(Jack Queen King Ace).freeze
  SUITS = %w(Hearts Clubs Diamonds Spades).freeze

  def initialize
    reset
  end

  def draw
    reset if @deck.empty?
    @deck.pop
  end

  private

  def reset
    @deck = RANKS.product(SUITS).map do |rank, suit|
      Card.new(rank, suit)
    end

    @deck.shuffle!
  end
end

class PokerHand
  attr_reader :hand, :kinds

  def initialize(deck)
    @hand = []
    @kinds = Hash.new(0)
    5.times do
      card = deck.draw
      hand << card
      self.kinds[card.rank] += 1
    end
  end
  # rest ommitted
end

# Danger danger danger: monkey
# patching for testing purposes:
# We are treating an Array of Cards as a Deck. Our #initialize
# method makes use of Card#draw to draw 5 cards, and by aliasing
# Array#pop as #draw, we are able to use #initialize to draw 5 cards
# from an Array of Cards.
# alias_method :new_method_name, :old_method_name
class Array
  alias_method :draw, :pop
end

#Test that we can identify each PokerHand type.
hand = PokerHand.new([
  Card.new(10,      'Hearts'),
  Card.new('Ace',   'Hearts'),
  Card.new('Queen', 'Hearts'),
  Card.new('King',  'Hearts'),
  Card.new('Jack',  'Hearts')
])
print 'Royal flush '
puts hand.evaluate == 'Royal flush'