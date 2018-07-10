################33
## Basic error handling:

x = 35
y = 0

begin
  z = x / y   # dividing by zero
  puts z
rescue => e # The e is an exception object that is created when
            # the error occurs.
  puts e
  p e
end

# divided by 0
# #<ZeroDivisionError: divided by 0>
# => exception object called ZeroDivisionError.

##############################
## Raising an error
# If the raise keyword does not have a specific exception as a
# parameter, a RuntimeError exception is raised setting its
# message to the given string
age = 17

begin
    if age < 18
        raise "Person is a minor"
    end

    puts "Entry allowed"
rescue => e
    puts e # print the error message and the string
           # representation of the RuntimeError
    p e
    exit 1  # call the exit method to inform the environment
            # that the execution of the script ended in error
end

# Person is a minor
# #<RuntimeError: Person is a minor>

###################
# Using ensure
# Ruby's ensure clause creates a block of code that always executes,
# whether there is an exception or not.
# Allocated resources are often placed in the ensure block.
begin
    f = File.open("stones", "r")

    while line = f.gets do
        puts line
    end

rescue => e
    puts e
    p e
ensure
    f.close if f
end

####################
# Creating custom exceptions
# Custom exceptions in Ruby should inherit from the StandardError class.
class BigValueError < StandardError ; end

LIMIT = 333
x = 3_432_453

begin

    if x > LIMIT
        raise BigValueError, "Exceeded the maximum value"
    end

    puts "Script continues"

rescue => e
    puts e
    p e
    exit 1
end

# Exceeded the maximum value
# #<BigValueError: Exceeded the maximum value>