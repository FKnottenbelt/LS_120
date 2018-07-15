=begin
What is the method lookup path and how is it important?
=end



=begin
Answer:
The method lookup path is the order in which Ruby will traverse the
class hierarchy to look for methods to invoke. For example, say you
have a Bulldog object called bud and you call: bud.swim. Ruby will
first look for a method called swim in the Bulldog class, then traverse
up the chain of super-classes; it will invoke the first method called
swim and stop its traversal.

In our simple class hierarchy, it's pretty straight forward. Things
can quickly get complicated in larger libraries or frameworks. To see
the method lookup path, we can use the .ancestors class method.

Bulldog.ancestors  # => [Bulldog, Dog, Pet, Object, Kernel, BasicObject]

Note that this method returns an array, and that all classes
sub-class from Object. Don't worry about Kernel or BasicObject for now.

=end