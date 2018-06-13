# Sandi Metz "Practical "Obejct-Oriented Design in Ruby"
## How to write easy to change code.

# 1- Insist it be simple
Your goal is to model your application, using classes, such that is does what is
supposed to do right now and also easy to change later

When things are not clear consider the future cost of doing nothing (class is
muddled, but has no dependencies. Reorganise when it does get dependencies).
When the future cost of doing nothing is the same as the current cost, postpone
the decision. Make the decision only when you mest with the information you have
at the time.

But: make sure the current design shows your intentions (others will copy)

# 2- Creating classes that have a single responsibility (cohesion)
A class should do the smallest possible useful thing; that is, it should have a
single responsibility.
  - altering the number of arguments that a method requires breaks all existing
    callers of the method
How do you know if it has a single responsibility?
1- Rephrase every one of its method as a question. Asking the question ought
   to make sense: 'Dear Gear, what is your tire size?' does not make sence,
   'Dear Gear what is your ratio' does.
2- Attempt to describe what the class does in one sentence. If you need 'and' or
   'or' to do it, than it has more than one responsibility. (has a central
   purpose. Which is not the same thing as doing only one thing.)

# 3- Writing code that embraces change
### 3a- Depend on behavior, not data:
- Hide instance variables
  Always wrap instance variables in accessor methods instead of directly
  reffering to variables.
- hide data structures
