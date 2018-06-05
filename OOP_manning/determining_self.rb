puts "Top Level"
puts "self is #{self}"  # self is main

class C

  puts "Class definition block: "
  puts  "self is #{self}"  # self is C

  def self.x
    puts "Class method C.x: "
    puts "self is #{self}"
  end

  def m
    puts "Instance method C#m:"
    puts "self is #{self}"
  end
end

puts '--- C calling'
C.x  # self is C
C.m  # error undefined method `m' for C:Class => not 'a Self'
puts '--- d calling'
d = C.new
d.m # self is #<C:0x00000001fcfbb0> (= instance of C)
d.x  # error: undefined method `x' for #<C:0x00000001fcfbb0> => is 'a Self'
