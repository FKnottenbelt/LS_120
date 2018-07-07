# Testing

Most programmers write too many test. Test everything just once and in
the proper place

The tests you write should be for messages that are defined in the
public interfaces

## What to test
- Incomming messages should be tested for the state they return
- Outgoing command messages should (only) be tested to ensure that they
  get send (with the correct parameters)
- Outgoing query messages should not be tested


state (here): return value
command message: has side effects (a file gets written, a database
record is saved, an action is taken by an observer etc)
query message: asking for state => is tested by receiving object.

## How to test

Your test should remain as ignorant as possible about context (everything
that is not the object under test)

Delete unused interfaces (incomming messages that has no dependents)
Yes, really. Unused code costs more to keep than to recover.
