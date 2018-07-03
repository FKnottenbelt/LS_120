# Writing Inheritable Code

More so than with other desing strategies sharing inherited
behavior requires very specific coding techniques.

## 1 - Recognize the Antipatterns
### a - missing subclass pattern
An object that uses a variable with a name like type or category
to determine what message to sent to self contains two highly
related but slightly different types.
=> create subtypes by adding subclasses
### b - missing ducktype pattern
A sending object checks the class of a receiving object to
determine what message to send.
=> role is ducktype. Make ducktype interface and if it needs
behavior (shared code) use a module for the role

## 2 - Insist on the Abstraction
All of the code in an abstract superclass should apply to
every class that inherits it. This also applies to modules:
the code must apply to all who use it
If subclasses override a method to raise an exception like 'does
not implement' they say 'I am not that thing' and you have got
a problem.
If you can not correctly identify the abstraction there might
not be one and inheritance is not the solution.

## 3 - Honor the Contract
Subclasses agree to a contract: they promise to be
substitutable for their superclass (Liskov Substitution
Principle):
An object should act like what it claims to be.
(mountainbike should act like a bicycle)

## 4 - Use the Template Method Pattern
This allows you to seperate the abstract from the concrete

## 5 - Preemtively Decouple Classes
Avoid writing code that requires its inheritors to send super.
Instead use hook messages.

## 6 - Create shallow Hierachies