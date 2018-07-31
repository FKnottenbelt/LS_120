=begin
How do you find where Ruby will look for a method when that method
is called? How can you find an object's ancestors?

module Taste
  def flavor(flavor)
    puts "#{flavor}"
  end
end

class Orange
  include Taste
end

class HotSauce
  include Taste
end

What is the lookup chain for Orange and HotSauce?
=end

module Taste
  def flavor(flavor)
    puts "#{flavor}"
  end
end

class Orange
  include Taste
end

class HotSauce
  include Taste
end

p Orange.ancestors
p HotSauce.ancestors
# [Orange, Taste, Object, Kernel, BasicObject]
# [HotSauce, Taste, Object, Kernel, BasicObject]

# ls
=begin
The list of ancestor classes is also called a lookup chain, because
Ruby will look for a method starting in the first class in the chain
(in this case HotSauce) and eventually lookup BasicObject if the method
is found nowhere in the lookup chain.

If the method appears nowhere in the chain then Ruby will raise a
NoMethodError which will tell you a matching method can not be found
anywhere in the chain.

Keep in mind this is a class method and it will not work if you call
this method on an instance of a class (unless of course that instance
has a method called ancestors).
=end