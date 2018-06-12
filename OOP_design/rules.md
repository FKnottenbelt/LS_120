# Sandi Metz "Practical "Obejct-Oriented Design in Ruby"
## How to write easy to change code.

# 1- Insist it be simple
Your goal is to modle your application, using classes, such that is does what is
supposed to do right now and also easy to change later

# 2- Creating classes that have a single responsibility
A class should do the smallest possible useful thing; that is, it should have a
single responsibility.
  - altering the number of arguments that a method requires breaks all existing
    callers of the method
How do you know if it has a single responsibility?
1- Rephrase every one of its method as a question. Asking the question ought
   to make sense: 'Dear Gear, what is your tire size?' does not make sence,
   'Dear Gear what is your ratio' does.
2- Attempt to describe what the class does in one sentence. If you need 'and' or
   'or' to do it, than it has more than one responsibility.
