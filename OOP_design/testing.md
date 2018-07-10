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

### Testing incomming messages
Your test should remain as ignorant as possible about context (everything
that is not the object under test)

Delete unused interfaces (incomming messages that has no dependents)
Yes, really. Unused code costs more to keep than to recover.

When the code in your tests uses the same collaborating objects
as the code in your application, your tests always break when they
should.
If you have *dependency injection* and you have only one canditate
for the role this makes sense.
However, it can be slow. And if you have many candidates you don't
want to have to inject all of them in your test.

Solution: make a fake one, a *test double* (stub) that gives only what
you need. (see test_double.rb)
However, this will not break the test if you change the interface.
(like rename the diameter method in a wheel like object)

If you change an interface, all player of the role should inplement
the new rol.
To make sure you don't forget test double playing the role is to
document the role. Assert the fact that a class plays the rol and
prove that it implements its interface correctly
(see document_role_test.rb: assert_respond_to(@wheel, :diameter))
NB: still doesn't solve all problems
**TO BE CONTINUED!**

## Testing private messages
Never write private messages if you can help it. And if you do,
never test them, unless of course it makes sense to do so. Therefore,
be biased against writing these test but do not fear to do so if
this would improve your lot.

## Testing outgoing messages
Don't test query messages.
