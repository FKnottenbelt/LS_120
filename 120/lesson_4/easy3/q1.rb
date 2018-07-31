=begin
If we have this code:

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

What happens in each of the following cases:

case 1:

hello = Hello.new
hello.hi

case 2:

hello = Hello.new
hello.bye

case 3:

hello = Hello.new
hello.greet

case 4:

hello = Hello.new
hello.greet("Goodbye")

case 5:

Hello.hi
=end

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

hello = Hello.new
hello.hi  # Hello

hello = Hello.new
# hello.bye # undefined method `bye' for #<Hello:0x0000000262f960>

hello = Hello.new
# hello.greet # in `greet': wrong number of arguments (given 0, expected 1)

hello = Hello.new
hello.greet("Goodbye") # Goodbye

Hello.hi # undefined method `hi' for Hello:Class

=begin
LS wording

    case 1

    "Hello" is printed to the terminal.

    case 2

    An undefined method error occurs. Neither the Hello class
    nor its parent class Greeting have a bye method defined.

    case 3

    An ArgumentError reporting a wrong number of arguments is
    returned. The Hello class can access its parent class's greet
    method, but greet takes an argument which is not being
    supplied if we just call greet by itself.


    case 4

    "Goodbye" is printed to the terminal.

    case 5

    An undefined method hi is reported for the Hello class.
    This is because the hi method is defined for instances of
    the Hello class, rather than on the class itself. So since
    we are attempting to call hi on the Hello class rather than
    an instance of the class, Ruby cannot find the method on the
    class definition.

=end