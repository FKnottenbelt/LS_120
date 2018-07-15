require 'minitest/autorun'
file = (File.basename __FILE__, ".*").sub!('_test', '')
puts "testing #{file}"
require_relative file

class HumanDouble < Player
  def gets
    @move
  end

  def human?
    true
  end
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
     # not doable with my knowledge level
     @human.move = 'rock'
     assert_equal @human.choose, 'rock'
  end

  def test_error_when_human_chooses_invalid_move
    # not doable with my knowledge level
    # @human.move = 'ice'
    # assert_equal @human.choose, "Sorry, invalid choice."
    # break (gets into endless loop)
  end

end