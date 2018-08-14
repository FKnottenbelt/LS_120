=begin
Further Exploration
You can write minilang programs that take input values by simply
interpolating values into the program string with Kernel#format. For
instance,

CENTIGRADE_TO_FAHRENHEIT =
  '5 PUSH %<degrees_c>d PUSH 9 MULT DIV PUSH 32 ADD PRINT'
Minilang.new(format(CENTIGRADE_TO_FAHRENHEIT, degrees_c: 100)).eval
# 212
Minilang.new(format(CENTIGRADE_TO_FAHRENHEIT, degrees_c: 0)).eval
# 32
Minilang.new(format(CENTIGRADE_TO_FAHRENHEIT, degrees_c: -40)).eval
# -40

This process could be simplified by passing some optional parameters
to eval, and using those parameters to modify the program string.

CENTIGRADE_TO_FAHRENHEIT =
  '5 PUSH %<degrees_c>d PUSH 9 MULT DIV PUSH 32 ADD PRINT'
minilang = Minilang.new(CENTIGRADE_TO_FAHRENHEIT)
minilang.eval(degrees_c: 100)
# 212
minilang.eval(degrees_c: 0)
# 32
minilang.eval(degrees_c: -40)
# -40

Try to implement this modification. Also, try writing other minilang
programs, such as one that converts fahrenheit to centigrade, another
that converts miles per hour to kilometers per hour (3 mph is
approximately equal to 5 kph). Try writing a program that needs
two inputs: for example, compute the area of a rectangle.
=end

# TO DO