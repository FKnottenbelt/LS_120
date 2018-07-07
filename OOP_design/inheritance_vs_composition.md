# Deciding between Inheritance and Composition

Classical inheritance is a code arrangement technique. Behavior is
dispersed among objects and these objects are organized into class
relationships such that automatic delegation of messages invokes the
correct behavior: For the cost of arranging objects in a hierarchy,
you get message delegation fo free.

Compositon is an alternative that reverses these costs and benifits.
Composition allows objects to have structural independencd, but at
the cost of explicit message delegation.

The general rule is that faced with a problem that compositon can
solve, you should be biased towards doing so.

# Choosing Relationships
- Use inheritance for a *is-a* relationship
- Use duck types for a *behaves-like-a* releationship
- Use compositon for a *has-a* relationship
