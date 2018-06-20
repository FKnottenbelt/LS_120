class ObscuringReferneces
  attr_reader :data

  def initialize(data)
    @data = data
  end

  def diameters
    # 0 is rim, 1 is tire
    data.map do |cell|
      cell[0] + cell[1] * 2
    end
  end

  #...many other methods that index into the array
end

#rim and tire sizes (now in milimeters) in a 2d array
@data = [[622,20], [622,23], [559, 30], [559, 40]]

# correct version:

class RevealingReferences
  attr_reader :wheels

  def initialize(data)
    @wheels = wheelify(data)
    puts "wheels after wheelify: #{wheels}"
  end

  def diameters  # calling attr_reader :wheels which has @wheels
    wheels.map do |wheel|
       wheel.rim + (wheel.tire * 2)
    end
  end

  # now everyone can send rim/tire to wheel
  # isolate knowledge of data structure
  Wheel = Struct.new(:rim, :tire)
  def wheelify(data)
    data.map do |cell|
      Wheel.new(cell[0], cell[1])
    end
  end
end

a = RevealingReferences.new([[622,20]])
p a.diameters
# wheels after wheelify: [#<struct RevealingReferences::Wheel rim=622,
# tire=20>]
# [662]
