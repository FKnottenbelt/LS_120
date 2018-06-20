# flexible interfaces

OOP is about message based. Not object based. Start with message, make
that find/define your objects. (you then need to find objects that can
reponds to your messages.)

OO applications are defined by the messages that pass between objects.
This message passing takes place along 'public' interfaces; well-defined
public interfaces consist of stable methods that expose the responsibilities
of their underlying classes and provide maximal benefit at minimal cost.

Focusing on messages reveals objects that might oterwise be overlooked.
Messages should be trusting and ask for what the sender wants instead of
telling the receiver how to behave.

Use sequence diagrams to help you define de messages and find responders

Ask for what instead of how

seek context independence (like dependency indjection, but in the
other direction)

trust other object to do their thing

you can put an array in you object with objects that can respond to
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