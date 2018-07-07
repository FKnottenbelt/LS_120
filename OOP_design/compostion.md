# Composition (and Aggregation)

A composed object is made up of parts with which it expects to
interact via well-defined interfaces.
Composition often involves delegation.
Composition describes a has-a releationship. (voelt database achtig.
1:n relatie, 'dat object heeft records')

meals have appetizers, univeristies have departments, bicycles have
parts. Meals, universities and bicycles are composed objects.
Appetizers, departments and parts are roles. The composed object
depends on the interface of the role.

Because meals interact with appetizers using an interface, new
objects that wish to act as appetizers need only implement this
interface.

When the contained object has no life independent of its
container => formal use of composition
When the contained object does have a life independent of its
container => aggregation (special form of composition)

example:
univeristy - department relationship = composition
department - professor = aggregation