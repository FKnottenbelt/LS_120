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
  end

  def total=(n)
    @total = n
  end

  def add_card(card)
    cards << card
    calculate_total
  end

  def hand
    "#{joiner(cards, ', ', 'and')}. Total is: #{total}"
  end

  def bust?
    total > BUST ? true : false
  end

  private

  def calculate_total
    non_aces = cards.select { |card| card.picture != 'Ace' }
    self.total = non_aces.map(&:value).sum

    aces = cards.count { |card| card.picture == 'Ace' }
    aces.times do
      total + 11 > BUST ? (self.total += 1) : (self.total += 11)
    end
  end
end

class Player
  include Hand

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
        cards << Card.new(counter, suite)
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
  MATCH = 2
  include Gameable

  attr_reader :player, :dealer
  attr_accessor :deck, :score

  def initialize
    @deck = Deck.new
    @dealer = Dealer.new
    @player = Player.new
    @score = { player: 0, dealer: 0 }
  end

  def start
    clear_screen
    display_welcome

    loop do
      play_match
      winner = declare_match_winner
      display_match_winner(winner)
      break unless play_again?
      reset_match
    end

    display_goodbye
  end

  private

  def play_match
    loop do
      deal_cards
      show_initial_dealer_card
      play_round
      break if someone_won?
      reset_round
    end
  end

  def play_round
    player_turn
    player_bust_actions if player.bust?

    dealer_turn unless someone_bust?
    dealer_bust_actions if dealer.bust?

    if !someone_bust?
      winner = declare_round_winner
      update_score(winner)
      display_round_winner(winner)
    end
  end

  def player_bust_actions
    display_player_bust
    update_score('dealer')
    show_score
  end

  def dealer_bust_actions
    display_dealer_bust
    update_score('player')
    show_score
  end

  def deal_cards
    2.times do
      player.add_card(deck.take_card)
      dealer.add_card(deck.take_card)
    end
  end

  def player_turn
    loop do
      player.show_hand
      break if someone_bust?

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
      break if someone_bust?

      action = dealer.hit_or_stay
      if action == 'hit'
        dealer.add_card(deck.take_card)
      else
        break
      end
    end
  end

  def reset
    self.deck = Deck.new
    player.cards = []
    dealer.cards = []
  end

  def reset_round
    reset
    display_next_round
  end

  def reset_match
    reset
    self.score = { player: 0, dealer: 0 }
    display_new_match
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

  def someone_bust?
    player.bust? || dealer.bust?
  end

  def someone_won?
    score.values.include?(MATCH)
  end

  ###  Display messages ##############

  def show_initial_dealer_card
    dealer.show_one_card
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

  def display_welcome
    bust = Player::BUST
    puts <<-MSG

                         Welcome to Twenty-One!
                  First to win #{MATCH} rounds, wins the match
    You are trying to get a card total as close as possible to #{bust}
            If you go over you are bust and lose the round


            MSG
  end

  def display_goodbye
    puts "Thank you for playing Twenty-One. Good bye!"
  end

  def display_player_bust
    puts
    puts "Oeps, you got a #{player.cards.last} and " \
      "went bust... Dealer wins."
  end

  def display_dealer_bust
    puts 'Dealer went bust! You won!'
  end

  def show_score
    puts "The rounds score is (get #{MATCH} to win): " \
    "player: #{score[:player]} - dealer: #{score[:dealer]}"
    puts
  end

  def display_new_match
    clear_screen
    message = []
    message << '-----------'
    message << "New Match!"
    message << '-----------'
    multi_line_prompt(message)
  end

  def display_next_round
    puts '-----------'
    puts "Next round!"
    puts '-----------'
  end
end

Game.new.start
