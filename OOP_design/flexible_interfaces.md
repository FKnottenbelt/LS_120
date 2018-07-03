# flexible interfaces

OOP is about message based. Not object based. Start with message, make
that find/define your objects. (you then need to find objects that can
reponds to your messages.)

OO applications are defined by the messages that pass between objects.
This message passing takes place along 'public' interfaces; well-defined
public interfaces consist of stable methods that expose the responsibilities
of their underlying classes and provide maximal benefit at minimal cost.

Focusing on messages reveals objects that might otherwise be overlooked.
Messages should be trusting and ask for what the sender wants instead of
telling the receiver how to behave.

Use sequence diagrams to help you define de messages and find responders

Ask for *what* instead of *how*

Seek context independence (like dependency indjection, but in the
other direction)

Trust other object to do their thing

You can put an array in your object with objects that can respond to
your message (like prepare_trip). This makes it easy to expand if you get
more 'prepareres'.

## rules of thumb for creating interfaces
### create explicit interfaces
Methods in the public interface should
- be explicitly defined as such (use private, public and protected)
- be more about *what* then *how*
- have names that, insofar as you can anticipate, will not change
- take a hash as an options parameter

Either do not write tests for your private methods, or segregate those
tests from the tests of public methods

# Demeters Law
Demeters Law is a set of coding rules that results in loosly
coupled objects. It restricts the set of object to which a method
may send messages; it prohibits routing a message to a
third object via a second object of a differnt type. "Only talk to
your immediate neighbours / use ony one dot".

If you find yourself breaking Demeter, go back to a message based
perspective to find a better public interface