def diameters
  wheels.map do |wheel|
    wheel.rim + (wheel.tire * 2)
  end
end

# split into iteration and action
# first iterate over the array
def diameters
  wheels.map { |wheel| diameter(wheel) }
end

# then caculate diamenter of ONE wheel
def diameter(wheel)
  wheel.rim + (wheel.tire * 2)
end

# wich also leads to
def gear_inches
  ratio * (rim + (tire * 2))
end

# into
def gear_inches
  ratio * diameter
end
