# cargohold.rb

require_relative 'stacklike'

class Suitcase
end

class CargoHold
  include Stacklike

  def load_and_report(obj)
    add_to_stack(obj)
    puts "adding suitcase #{obj.object_id} to cargohold"
  end

  def unload
    take_from_stack
  end
end

ch = CargoHold.new
sc1 = Suitcase.new
sc2 = Suitcase.new
sc3 = Suitcase.new

ch.load_and_report(sc1)
ch.load_and_report(sc2)
ch.load_and_report(sc3)

first_unloaded = ch.unload
puts "first unloaded was #{first_unloaded.object_id}"
