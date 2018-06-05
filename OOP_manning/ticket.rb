class Ticket
  attr_reader :venue, :date
  attr_accessor :price

  def initialize(venue, date)
    puts "Creating new ticket. ID #{self.object_id}"
    @venue = venue
    @date = date
  end

end

t1 = Ticket.new('Town Hall', "01-01-2018")
t2 = Ticket.new('Town Square', "10-03-2018")
t1.price = 13.00
p t1.date
p t2.date
p t1.price
p t2.price
t1.price = 13.2345
p t1.price
t1.price = 12.00
p t1.price
