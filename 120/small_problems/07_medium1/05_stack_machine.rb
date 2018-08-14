=begin

Stack Machine Interpretation

This is one of the hardest exercises in this exercise set. It uses both
exceptions and Object#send, neither of which we've discussed in detail
before now. Think of this exercise as one that pushes you to learn new
things on your own, and don't worry if you can't solve it.

You may remember our Minilang language from back in the 101 Medium exercises.
We return to that language now, but this time we'll be using OOP. If you need
a refresher, refer back to that exercise.

Write a class that implements a miniature stack-and-register-based
programming language that has the following commands:

n Place a value n in the "register". Do not modify the stack.
PUSH Push the register value on to the stack. Leave the value in the register.
ADD Pops a value from the stack and adds it to the register value, storing the
  result in the register.
SUB Pops a value from the stack and subtracts it from the register value,
  storing the result in the register.
MULT Pops a value from the stack and multiplies it by the register value,
  storing the result in the register.
DIV Pops a value from the stack and divides it into the register value,
  storing the integer result in the register.
MOD Pops a value from the stack and divides it into the register value,
  storing the integer remainder of the division in the register.
POP Remove the topmost item from the stack and place in register
PRINT Print the register value

All operations are integer operations (which is only important with DIV and
MOD).

Programs will be supplied to your language method via a string passed in as
an argument. Your program should produce an error if an unexpected item is
present in the string, or if a required stack value is not on the stack when
it should be (the stack is empty). In all error cases, no further processing
should be performed on the program.

You should initialize the register to 0.

Examples:

Minilang.new('PRINT').eval
# 0

Minilang.new('5 PUSH 3 MULT PRINT').eval
# 15

Minilang.new('5 PRINT PUSH 3 PRINT ADD PRINT').eval
# 5
# 3
# 8

Minilang.new('5 PUSH 10 PRINT POP PRINT').eval
# 10
# 5

Minilang.new('5 PUSH POP POP PRINT').eval
# Empty stack!

Minilang.new('3 PUSH PUSH 7 DIV MULT PRINT ').eval
# 6

Minilang.new('4 PUSH PUSH 7 MOD MULT PRINT ').eval
# 12

Minilang.new('-3 PUSH 5 XSUB PRINT').eval
# Invalid token: XSUB

Minilang.new('-3 PUSH 5 SUB PRINT').eval
# 8

Minilang.new('6 PUSH').eval
# (nothing printed; no PRINT commands)
=end

module Stacklike
  def stack
    @stack ||= []
  end
end

class Minilang
  include Stacklike

  attr_reader :program

  def initialize(program)
    @program = program
  end

  def eval
    run_program(program)
  end

  private

  def run_program(program)
    register = 0
    begin

    program.split.each do |token|

      raise "Invalid token: #{token}" if !valid_token?(token)
      raise "Empty stack!" if invalid_stack?(token)

      case token
      when 'ADD'   then register += stack.pop
      when 'DIV'   then register /= stack.pop
      when 'MULT'  then register *= stack.pop
      when 'MOD'   then register %= stack.pop
      when 'SUB'   then register -= stack.pop
      when 'PUSH'  then stack.push(register)
      when 'POP'   then register = stack.pop
      when 'PRINT' then puts register
      else              register = token.to_i
      end
    end

    rescue RuntimeError => e
      p e.message
    end
  end

  def valid_token?(token)
    %w[ADD DIV MULT MOD SUB PUSH POP PRINT].include?(token) ||
    valid_integer?(token)
  end

  def invalid_stack?(token)
    token != 'PRINT' && token != 'PUSH' && !valid_integer?(token) &&
    stack.empty?
  end

  def valid_integer?(n)
    n.to_i.to_s == n
  end

end

Minilang.new('PRINT').eval
# 0

Minilang.new('5 PUSH 3 MULT PRINT').eval
# 15

Minilang.new('5 PRINT PUSH 3 PRINT ADD PRINT').eval
# 5
# 3
# 8

Minilang.new('5 PUSH 10 PRINT POP PRINT').eval
# 10
# 5

Minilang.new('5 PUSH POP POP PRINT').eval
# Empty stack!

Minilang.new('3 PUSH PUSH 7 DIV MULT PRINT ').eval
# 6

Minilang.new('4 PUSH PUSH 7 MOD MULT PRINT ').eval
# 12

Minilang.new('-3 PUSH 5 XSUB PRINT').eval
# Invalid token: XSUB

Minilang.new('-3 PUSH 5 SUB PRINT').eval
# 8

Minilang.new('6 PUSH').eval
# (nothing printed; no PRINT commands)