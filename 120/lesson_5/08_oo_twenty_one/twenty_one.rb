module Hand

  def cards
    @cards ||= []
  end

  def total
    # definitely looks like we need to know about "cards" to produce some
    # total
  end

  def add_card(card)
    cards << card
  end

end

class Player
  include Hand

  def initialize
    # what would the "data" or "states" of a Player object entail?
    # maybe cards? a name?
  end

  def hit
  end

  def stay
  end

  def busted?
  end

end

class Dealer
  include Hand

  def initialize
    # seems like very similar to Player... do we even need this?
  end

  def deal
    # does the dealer or the deck deal?
  end

  def hit
  end

  def stay
  end

  def busted?
  end


end

module Gameable
  def play_again?
    answer = ''
    loop do
      puts "Would you like to play again? (y/n)"
      answer = gets.chomp.downcase
      break if %w[y yeah yes yep n no nope].include?(answer)
      puts 'Please answer y (yes) or n (no)'
    end
    %w[y yeah yes yep].include?(answer)
  end

  def clear_screen
    system("cls") || system("clear")
  end

  def joiner(arr, delimiter=', ', word='or')
    arr << arr.pop(2).join(' ' + word + ' ')
    arr.join(delimiter)
  end
end

class Deck
  SUITES = ['hearts', 'diamonds', 'clubs', 'spades']

  attr_accessor :cards

  def initialize
    @cards = []
    build_up_new_deck
  end

  def build_up_new_deck
    add_number_cards!
    add_picture_cards!
  end

  def add_number_cards!
    counter = 1
    loop do
      break if counter == 14
      SUITES.each do |suite|
        self.cards << Card.new(counter, suite)
      end
      counter += 1
    end
  end

  def add_picture_cards!
    cards.each do |card|
      card.picture =
      case card.value
      when 1  then 'Ace'
      when 11 then 'Jack'
      when 12 then 'Queen'
      when 13 then 'King'
      end
    end
  end

end

class Card
  attr_reader :suite
  attr_accessor :picture, :value

  def initialize(value, suite)
    @value = value
    @suite = suite
  end

  def to_s
    if picture.nil?
      "#{value} of #{suite}"
    else
      "#{picture} of #{suite}"
    end
  end
end

class Game
  include Gameable

  attr_reader :player, :dealer, :deck

  def initialize
    @deck = Deck.new
    @dealer = Dealer.new
    @player = Player.new
  end

  def start
    deal_cards
    show_initial_cards
    # player_turn
    # dealer_turn
    # show_result
  end

  private

  def deal_cards
    2.times do
      player.add_card(deck.cards.shuffle.pop)
      dealer.add_card(deck.cards.shuffle.pop)
    end
  end

  def show_initial_cards
    player_cards = joiner(player.cards,', ','and')
    dealer_cards = joiner(dealer.cards,', ','and')
    puts "Player has: #{player_cards}"
    puts "Dealer has: #{dealer_cards}"
  end
end


Game.new.start

