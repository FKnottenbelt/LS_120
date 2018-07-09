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

When the code in your tests uses the same collaborating objects
as the code in your application, your tests always break when they
should
If you have dependency injection and you have only one canditate
for the role this makes sense.
However, it can be slow. And if you have many candidates you don't
want to have to inject all of them in your test.
Solution: make a fake one, a test double (stub) that gives only what
you need. (see test_double.rb)