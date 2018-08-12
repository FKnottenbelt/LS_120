module Gameable
  LINE_WIDTH = 80

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

  def multi_line_prompt(messages_array)
    puts
    messages_array.each do |line|
      puts line.center(LINE_WIDTH)
    end
    puts
  end
end

module Hand
  BUST = 21

  include Gameable

  attr_writer :cards

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
  DEALER_MAX = 17

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

  def show_one_card
    puts "Dealer has #{cards.sample}"
  end

  def hit_or_stay
    total <= DEALER_MAX ? 'hit' : 'stay'
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
  MATCH = 2
  include Gameable

  attr_reader :player, :dealer, :score
  attr_accessor :deck

  def initialize
    @deck = Deck.new
    @dealer = Dealer.new
    @player = Player.new
    @score = { player: 0, dealer: 0 }
  end

  def start # match
    clear_screen
    # display welcome
    puts
    puts "Welcome to TwentyOne"

    loop do # round
      deal_cards
      show_initial_dealer_card

      player_turn

      if player.bust?
        puts
        puts "Oeps, you got a #{player.cards.last} and " \
        "went bust... Dealer wins."
        score[:dealer] += 1
        show_score
      else
        dealer_turn
        if dealer.bust?
          puts 'Dealer went bust! You won!'
          score[:player] += 1
          show_score
        else
         winner = declare_round_winner
         update_score(winner)
         display_round_winner(winner)
        end
      end

      break if score.values.include?(MATCH) # somebody won
      break unless play_again?

      reset
    end # round

    winner = declare_match_winner
    display_match_winner(winner)
    puts "Thank you for playing Twenty-One. Good bye!"
  end

  private

  def deal_cards
    2.times do
      player.add_card(deck.take_card)
      dealer.add_card(deck.take_card)
    end
  end

  def show_initial_dealer_card
    dealer.show_one_card
  end

  def player_turn
    loop do
      player.show_hand
      answer = player.ask_hit_or_stay
      if answer == 'h'
        player.add_card(deck.take_card)
        break if player.bust?
      else
        break
      end
    end
  end

  def dealer_turn
    loop do
      action = dealer.hit_or_stay
      if action == 'hit'
        dealer.add_card(deck.take_card)
      else
        break
      end
    end
  end

  def show_score
    puts "The rounds score is (get #{MATCH} to win): " \
    "player: #{score[:player]} - dealer: #{score[:dealer]}"
    puts
  end

  def reset
    self.deck = Deck.new
    player.cards = []
    dealer.cards = []
    puts '-----------'
    puts "Next round!"
    puts '-----------'
  end

  def declare_round_winner
    player_total = player.total
    dealer_total = dealer.total

    if player_total > dealer_total
      'player'
    elsif player_total == dealer_total
      'tie'
    else
      'dealer'
    end
  end

  def declare_match_winner
    if score[:player] == score[:dealer]
      'tie'
    else
      score.key(score.values.max).to_s
    end
  end

  def update_score(winner)
    return if winner == 'tie'
    score[winner.to_sym] += 1
  end

  def display_round_winner(winner)
    message = []
    message << "The winner of this round is: #{winner}!"
    message << "score: player: #{player.total} - dealer: #{dealer.total}"
    message << "rounds score: player: #{score[:player]} - dealer: " \
               "#{score[:dealer]}"
    message << "(win #{MATCH} rounds to win a match)"
    multi_line_prompt(message)
  end

  def display_match_winner(winner)
    message = []
    message << "The winner of this match is: #{winner}!"
    message << "score: player: #{score[:player]} - dealer: #{score[:dealer]}"
    multi_line_prompt(message)
  end
end


Game.new.start

