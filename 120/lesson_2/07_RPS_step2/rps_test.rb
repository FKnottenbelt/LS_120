require 'minitest/autorun'
file = (File.basename __FILE__, ".*").sub!('_test', '')
puts "testing file #{file}"
require_relative file

module UserInput
  attr_accessor :user_input

  def types(user_input)
    @user_input = user_input
  end

  def gets
    self.user_input
  end
end

class HumanDouble < Player
  include UserInput
end

class PlayerTest < MiniTest::Test
  def setup
    @human = HumanDouble.new
    @computer = Player.new(:computer)
  end

  def test_computer_chooses_sample
    assert_equal choice = @computer.choose,
       ['rock', 'paper', 'scissors'].delete(choice)
  end

  def test_human_chooses_valid_move
     @human.types 'rock'
     assert_equal 'rock', @human.choose
     puts "player choice was rock"
  end

  def test_human_chooses_invalid_move
    # not doable with my knowledge level
    puts "MANUAL TEST: human_chooses_invalid_move"
  end

end
