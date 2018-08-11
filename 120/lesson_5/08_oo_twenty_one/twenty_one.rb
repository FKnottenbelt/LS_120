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
    array = arr.dup
    array << array.pop(2).join(' ' + word + ' ')
    array.join(delimiter)
  end
end

module Hand
  BUST = 21

  include Gameable

  def cards
    @cards ||= []
  end

  def total
    @total ||= 0
    # definitely looks like we need to know about "cards" to produce some
    # total
  end

  def total=(n)
    @total =  n
  end

  def add_card(card)
    cards << card
    calculate_total
  end

  def hand
    "#{joiner(cards,', ','and')}. Total is: #{total}"
  end

  def bust?
    total > BUST ? true : false
  end

  private

  def calculate_total
    non_aces = cards.select { |card| card.picture != 'Ace'}
    self.total = non_aces.map(&:value).sum

    aces = cards.count { |card| card.picture == 'Ace'}
    aces.times do
      self.total + 11 > BUST ? (self.total += 1) : (self.total += 11)
    end
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

  def show_hand
    puts
    puts "You have: #{hand}"
  end

  def ask_hit_or_stay
    answer = ''
    loop do
      puts "Do you want to hit or stay? (h/s)"
      answer = gets.chomp.downcase
      break if %w[h s].include?(answer)
      puts "Please type h for hit or s for stay"
    end
    answer
  end
end

class Dealer
  include Hand

  def initialize

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

  def show_hand
    puts "Dealer has: #{hand}"
  end
end

class Deck
  SUITES = ['hearts', 'diamonds', 'clubs', 'spades']

  attr_accessor :cards

  def initialize
    @cards = []
    build_up_new_deck
  end

  def take_card
    cards.shuffle!.pop
  end

  def no_cards_in_deck
    cards.count
  end

  private

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
      when 11 then 'Ace'
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
    player_turn
    # dealer_turn
    # show_result
  end

  private

  def deal_cards
    2.times do
      player.add_card(deck.take_card)
      dealer.add_card(deck.take_card)
    end
  end

  def show_initial_cards
    puts "Player has: #{player.hand}"
    puts "Dealer has: #{dealer.hand}"
  end

  def player_turn
    loop do
      player.show_hand
      #show_score(score)
      answer = player.ask_hit_or_stay
      if answer == 'h'
        player.add_card(deck.take_card)
        player.show_hand
        # show message if bust (or win I guess)
        break if player.bust?
      else
        break
      end
    end
  end
end


Game.new.start

