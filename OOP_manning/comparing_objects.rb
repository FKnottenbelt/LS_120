# comparing_objects.rb
class Bid
  include Comparable
  attr_accessor :estimate
  def <=>(other_bid)
    self.estimate <=> other_bid.estimate
  end
  # def <=>(other_bid)
  #   if self.estimate < other_bid.estimate
  #     -1
  #   elsif self.estimate > other_bid.estimate
  #     1
  #   else
  #     0
  #   end
  # end
end


bid1 = Bid.new
#<Bid:0x000001011d5d60>
bid2 = Bid.new
#<Bid:0x000001011d4320>
bid1.estimate = 100
#=> 100
bid2.estimate = 105
#=> 105
p bid1 < bid2
#=> true


