# replacing the Part class by an openstruct in the factory
require 'forwardable'
require 'ostruct' # <== OpenStruct (like Struct, but with hash)

module PartsFactory
  def self.build(config, parts_class = Parts)
    parts_class.new(
      config.map do |part_config|
        create_part(part_config)
      end)
  end

  def self.create_part(part_config)
    OpenStruct.new(
      name: part_config[0],
      description: part_config[1],
      needs_spare: part_config.fetch(2, true))
  end
end

class Parts
  extend Forwardable
  def_delegators :@parts, :size, :each
  include Enumerable

  def initialize(parts)
    @parts = parts
  end

  def spares
    select{ |part| part.needs_spare }
  end

end

# specifying parts for bikes in configs

road_config =
  [['chain', '10-speed'],
   ['tire_size', '23'],
   ['tape_coler', 'red']]

mountain_config =
  [['chain', '10-speed'],
   ['tire_size', '2.1'],
   ['front_shock', 'Mantiou', false],
   ['rear_shock', 'Fox']]

# using the factory to make Parts
p road_parts = PartsFactory.build(road_config)
puts
p mountain_parts = PartsFactory.build(mountain_config)

#<Parts:0x00000001873ab0 @parts=[#<Parts:0x00000001873d58 @parts={:name=>"chain", :description=>"10-speed", :needs_spare=>true}>, #<Parts:0x00000001873cb8 @parts={:name=>"tire_size", :description=>"23", :needs_spare=>true}>, #<Parts:0x00000001873bc8 @parts={:name=>"tape_coler", :description=>"red", :needs_spare=>true}>]>

#<Parts:0x0000000186dcf0 @parts=[#<Parts:0x0000000186e498 @parts={:name=>"chain", :description=>"10-speed", :needs_spare=>true}>, #<Parts:0x0000000186e290 @parts={:name=>"tire_size", :description=>"2.1", :needs_spare=>true}>, #<Parts:0x0000000186e060 @parts={:name=>"front_shock", :description=>"Mantiou", :needs_spare=>false}>, #<Parts:0x0000000186de80 @parts={:name=>"rear_shock", :description=>"Fox", :needs_spare=>true}>]>