## LS solution
require 'set'

class MinilangRuntimeError < RuntimeError; end
class BadTokenError < MinilangRuntimeError; end
class EmptyStackError < MinilangRuntimeError; end

class Minilang
  ACTIONS = Set.new %w(PUSH ADD SUB MULT DIV MOD POP PRINT)

  def initialize(program)
    @program = program
    @stack = []
    @register = 0
  end

  def eval
    @program.split.each { |token| eval_token(token) }
  rescue MinilangRuntimeError => error
    puts error.message
  end

  private

  def eval_token(token)
    if ACTIONS.include?(token)
      send(token.downcase)
    elsif token =~ /\A[-+]?\d+\z/
      @register = token.to_i
    else
      raise BadTokenError, "Invalid token: #{token}"
    end
  end

  def push
    @stack.push(@register)
  end

  def pop
    raise EmptyStackError, "Empty stack!" if @stack.empty?
    @register = @stack.pop
  end

  def add
    @register += pop
  end

  def div
    @register /= pop
  end

  def mod
    @register %= pop
  end

  def mult
    @register *= pop
  end

  def sub
    @register -= pop
  end

  def print
    puts @register
  end
end

=begin
In some ways, this problem is easier to solve than its procedural version,
but error handling makes things a bit more complicated. We also take a
somewhat different approach to performing each operation, using separate
methods instead of a case.

We start by observing that our interface, as shown in the examples, calls for
a class named Minilang, and an initializer that takes our minilang program
as a string input. The interface also requires an eval method to evaluate
and run the program. So, we set up a class that does just this.

Our initialize method creates instance variables, @register and @stack, for
use in emulating the stack and register of our language processor.

The eval method iterates through all of our tokens, processing them one at
a time. It also captures and reports any exceptions raised during processing.

Both of the exceptions we can raise are defined as subclasses of the
MinilangRuntimeError exception class, which, in turn, is a subclass of
the standard RuntimeError exception class. Having MinilangRuntimeError between RuntimeError and our two real exception classes lets us easily rescue either of the exceptions that may occur.

eval calls our workhorse method, eval_token for each token in our program.
You might, at this point, be tempted to use something like Kernel#respond_to?
to distinguish actions that can be executed, but this isn't precise, and
will likely cause unexpected behaviors. To avoid this, we instead keep a
list of valid tokens in ACTIONS, and check that list for the action tokens
we want. If we find one, we call the appopriate method via Object#send.

In addition to action tokens, we also need to handle integer tokens, so we
check for integer values using the regex shown, and, if we have a match, we
just convert the token to an integer and stick it in our register, replacing
whatever value was already there.

If the token is neither a valid action nor an integer token, we raise a
BadTokenError exception to terminate the program.

All of the actions are implemented as very simple (mostly one-liner)
methods named for each action. Each method operates on our @stack and
@register instance variables, and performs the specific action requested.
=end