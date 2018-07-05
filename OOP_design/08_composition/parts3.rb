# The compromise
# https://vaidehijoshi.github.io/blog/2015/03/31/delegating-all-of-the-things-with-ruby-forwardable/
require 'forwardable'

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

class Parts
  extend Forwardable  # makes this available as class methods
  # method of Forwardable with arguments: object to sent to (in this case
  # the array @parts), list of methods to foward to it. is same as:
  # delegate [:size, :each] => :@parts
  # "if I, the Parts object call these methods, send it to @parts to
  # handle"
  def_delegators :@parts, :size, :each

  # makes this available to Parts objects and gives that it had
  # something to forward to our @parts array?
  include Enumerable

  def initialize(parts)
    @parts = parts  #array of part objects
  end

  def spares # @parts is an array of part objects
    select{ |part| part.needs_spare } # gives array of
         # part objects that need spares. We can do the select
         # because enumerable gave :each (giving it :select would
         # also have worked) to us to foward to the
         # @parts array
  end

end

class Part
  attr_reader :name, :description, :needs_spare

  def initialize(args)
    @name = args[:name]
    @description  = args[:description]
    @needs_spare = args.fetch(:needs_spare, true)
  end
end


class MethodNotImplemented < StandardError
end

# making part objects
chain = Part.new(name: 'chain', description: '10-speed')
road_tire = Part.new(name: 'tire_size', description: '23')
tape = Part.new(name: 'tape_color', description: 'red')
mountain_tire = Part.new(name: 'tire_size', description: '2.1')
front_shock = Part.new(name: 'front_shock', description: 'Manitou',
                        needs_spare: false)
rear_shock = Part.new(name: 'rear_schock', description: 'Fox')


# making the bikes
road_bike = Bicycle.new(size: 'L',
                        parts: Parts.new([chain, road_tire, tape]))
p road_bike.size
p road_bike.spares # array with 3 part objects


mountain_bike = Bicycle.new(
                  size: 'L',
                  parts: Parts.new([chain, front_shock,
                                    mountain_tire, rear_shock]))
p mountain_bike.size
p mountain_bike.spares # array with 3 part objects


p mountain_bike.spares.size # 3
p mountain_bike.parts.size # 4

