# Inheritance

Inheritance is at its core, a mechanism for automatic message
delegation. It defines a path for not-understood messages.

Like with ducktyping there is a pattern to detect 'missing
subclasses':
If the code contains an if statement that checks an attribute that
holds the category of self to determine what message to send to
self.
"if style == :road"
If you see variables called type or category, take note!

Message forwarding via classical inheritance takes place between
classes. Because ducktypes cuts across classes, they do not use
classical inheritance to share common behavior. Duck types share
code via Modules.

# Two rules of inheritance:
1- The object you are modeling must truly have a generalization-
specialization relationship
2- You must use the correct coding techniques
   - create an abstract superclass by promoting abstractions
   - use the temple method pattern
   - Do not let subs send super but let super send hook messages
     (like: use post_initialize hook messages. NB sub change
     their initialize to post_initialize!)

Create an abstract superclass.
Abstract classes exist to be subclassed. This is their sole purpose
They provide a common repository for behavior that is shared
across a set of subclasses - subclasses that in turn supply
specialization.
=> first make your class a subclass. Then promote the abstract
behavior up to the superclass. NOT the other way around!
(the general rule for refactoring into a new inheritance
hierarchy is to arrange code so that you can promote abstractions
rather than demote concretions)

Use the temple method pattern:
This is the technique of defining a basic structure in the
superclass and sending messages to acquire subclass-specific
contributions. (see bicycle6.rb)
- Always document template method requirements by implementing
matching methods that raise usefull errors ('warn' new subclasses)

You can let your subclasses initialize their specialized
attribute and then send args to super for the rest. (see
bicycle7.rb.) But this is still knowing to much. Instead use
hook messages (like post_initialize) to give full responsibilty
to the superclass instead of making the subs know about the
super. (see bicycle9.rb)
