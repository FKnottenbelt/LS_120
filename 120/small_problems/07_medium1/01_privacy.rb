# Consider the following class:
#
# class Machine
#   attr_writer :switch
#
#   def start
#     self.flip_switch(:on)
#   end
#
#   def stop
#     self.flip_switch(:off)
#   end
#
#   def flip_switch(desired_state)
#     self.switch = desired_state
#   end
# end
#
# Modify this class so both flip_switch and the setter method switch= are
# private methods.


class Machine

  def start
    flip_switch(:on)
  end

  def stop
    flip_switch(:off)
  end

  private
  attr_writer :switch

  def flip_switch(desired_state)
    self.switch = desired_state
  end
end

lamp = Machine.new
lamp.start
lamp.stop

# The trickier part is the call to the setter method: unlike all
# other private method calls, you must specify the receiver when
# calling a setter method. If you try to remove the receiver, ruby
# will create a local variable named switch.

# Further Exploration

# Add a private getter for @switch to the Machine class, and add
# a method to Machine that shows how to use that getter.