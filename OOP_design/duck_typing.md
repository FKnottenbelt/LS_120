# Duck typing

Messages are at the center of object-oriented applictions
and they pass among objects along public interfaces.
Duck typing detaches these public interfaces from
specific classes creating virtual types that are
defined by what they do instead of by who they are.
They are across-class interfaces, that can be used in
addition to the class own public interface.
Duck typing reveals underlying abstractions.

NB: this only works in dynamic typed languages.

## Recognizing ducks:
- case statements that switch on class
- kind_of? and is_a?
- responds_to?
