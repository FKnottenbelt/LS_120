=begin
What could we add to the class below to access the instance variable @volume?

class Cube
  def initialize(volume)
    @volume = volume
  end
end
=end


class Cube
  attr_accessor :volume
  def initialize(volume)
    @volume = volume
  end
end

# ls:
# option 1 (don't)
big_cube = Cube.new(5000)
big_cube.instance_variable_get("@volume")

# option 2
class Cube
  def initialize(volume)
    @volume = volume
  end

  def get_volume
    @volume
  end
end