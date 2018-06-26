# Inheritance

Inheritance is at its core, a mechanism for automatic message
delegation. It defines a pathe for not-understood messages.

Like with ducktyping there is a pattern to detect 'missing
subclasses':
If the code contains an if statement that check an attribute that
holds the category of self to determine what message to send to
self.
"if style == :road"
If you see variables called type or category, take note!

Message forwarding via classical inheritance takes place between
classes. Because ducktypes cut across classes, the do not use
classical inheritance to share common behavior. Duck types share
code via Modules.

= anki:
# Two rules of inheritance:
1- the object you are modeling must truly have a generalization-
specialization relationship
2- you must use the correct coding techniques [?]

Create an abstract superclass.
Abstract classes exist to be subclassed. This is their sole purpose
They provede a common repository for bahavior that is shared
across a set of subclassess - subclasses that in turn supply
specialization.
=> first make your class a subclass. Than promote the abstract
behavior up to the superclass. NOT the other way around!
(the general rule for refactoring into a new inheritance
hierarchy is to arrange code so that you can promote abstractions
rather than demote concretions)

