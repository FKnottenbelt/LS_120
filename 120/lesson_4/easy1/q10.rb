=begin
If we have the class below, what would you need to call to create a
new instance of this class.

class Bag
  def initialize(color, material)
    @color = color
    @material = material
  end
end

=end

class Bag
  def initialize(color, material)
    @color = color
    @material = material
  end
end

red_bag = Bag.new('red', 'canvas')
p red_bag.instance_variable_get('@color')
p red_bag.instance_variable_get('@material')