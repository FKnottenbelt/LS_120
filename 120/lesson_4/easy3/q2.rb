=begin
In the last question we had the following classes:

class Greeting
  def greet(message)
    puts message
  end
end

class Hello < Greeting
  def hi
    greet("Hello")
  end
end

class Goodbye < Greeting
  def bye
    greet("Goodbye")
  end
end

If we call Hello.hi we get an error message. How would you fix this?
=end

# option 1
class Greeting
  def greet(message)
    puts message
  end
end

class Hello < Greeting
  def hi
    greet("Hello")
  end
end

class Goodbye < Greeting
  def bye
    greet("Goodbye")
  end
end

h = Hello.new
h.hi

# option 2
class Greeting
  def greet(message)
    puts message
  end
end

class Hello < Greeting
  def hi
    greeting = Greeting.new
    greeting.greet("Hello")
  end
end

class Goodbye < Greeting
  def bye
    greet("Goodbye")
  end
end

h = Hello.new
h.hi