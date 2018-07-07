
require 'ostruct'
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

class MethodNotImplemented < StandardError
end

class Bicycle
  attr_reader :size, :parts

  def initialize(args={})
    @size = args[:size]
    @parts = args[:parts]
  end

  def spares
    parts.spares
  end
end

require 'forwardable'
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

# making bikes
road_bike = Bicycle.new(
              size: 'L',
              parts: PartsFactory.build(road_config))

p road_bike.spares
# [#<OpenStruct name="chain", description="10-speed", needs_spare=true>, #<OpenStruct name="tire_size", description="23", needs_spare=true>, #<OpenStruct name="tape_coler", description="red", needs_spare=true>]

mountain_bike = Bicycle.new(
                  size: 'L',
                  parts: PartsFactory.build(mountain_config))

p mountain_bike.spares

# lets add a totally new bike
recumbent_config =
  [['chain', '9-speed'],
   ['tire_size', '28'],
   ['flag', 'tall and orange']]

recumbent_bike = Bicycle.new(
                   size: 'L',
                   parts: PartsFactory.build(recumbent_config))

p recumbent_bike.spares