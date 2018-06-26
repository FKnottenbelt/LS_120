# checking style: 'missing subclass' pattern

def spare
  if style == :road
    { chain: '10-speed',
      tire_size: '23',
      tape_color: tape_color }
  else
    { chain: '10-speed',
      tire_size: '2.1',
      rear_shock: rear_shock }
  end
end

