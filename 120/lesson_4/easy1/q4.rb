=begin
If we have a class AngryCat how do we create a new instance of this class?

The AngryCat class might look something like this:

class AngryCat
  def hiss
    puts "Hisssss!!!"
  end
end
=end

class AngryCat
  def hiss
    puts "Hisssss!!!"
  end
end

grumpy = AngryCat.new
grumpy.hiss