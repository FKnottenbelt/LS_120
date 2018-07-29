# Fake Operators

One reason Ruby is hard for beginners is due to its liberal syntax. We've
already seen from the Equivalence assignment that the "double equals"
equality operator, ==, is actually a method and not a real operator. It
only looks like an operator because Ruby gives us special syntactical sugar
when invoking that method. Instead of calling the method normally
(eg. str1.==(str2)), we can call it with a special syntax that reads more
naturally (eg. str1 == str2).

This might have triggered the question: what other operators are actually
methods being invoked with special syntax? Are all operators, in fact,
methods? Below is a table that shows which operators are real operators,
and which are methods disguised as operators (listed by order of precedence;
highest first).

 | Method | Operator                                                                              | Description                                                                         |
|--------|---------------------------------------------------------------------------------------|-------------------------------------------------------------------------------------|
| yes    | `[]`, `[]=`                                                                           | Collection element getter and setter.                                               |
| yes    | `**`                                                                                  | Exponential operator                                                                |
| yes    | `!`, `~`, `+`, `-`                                                                    | Not, complement, unary plus and minus (method names for the last two are +@ and -@) |
| yes    | `*`, `/`, `%`                                                                         | Multiply, divide, and modulo                                                        |
| yes    | `+`, `-`                                                                              | Plus, minus                                                                         |
| yes    | `>>`, `<<`                                                                            | Right and left shift                                                                |
| yes    | `&`                                                                                   | Bitwise "and"                                                                       |
| yes    | `^`,`|`                                                                 | Bitwise exclusive "or" and regular "or" (inclusive "or")                                          |
| yes    | `<=`, `<`, `>`, `>=`                                                                  | Less than/equal to, less than, greater than, greater than/equal to                  |
| yes    | `<=>`, `==`, `===`, `!=`, `=~`, `!~`                                                  | Equality and pattern matching (`!=` and `!~` cannot be directly defined)            |
| no     | `&&`                                                                                  | Logical "and"                                                                       |
| no     | `||`                                                                                  | Logical "or"                                                                        |
| no     | `..`, `...`                                                                           | Inclusive range, exclusive range                                                    |
| no     | `? :`                                                                                 | Ternary if-then-else                                                                |
| no     | `=`, `%=`, `/=`, `-=`, `+=`, `|=`, `&=`, `>>=`, `<<=`, `*=`, `&&=`, `||=`, `**=`, `{` | Assignment (and shortcuts) and block delimiter                                      |

The operators marked with a "yes" in the "Method" column means that
these operators are in fact methods, which means we can override their
functionality. This appears to be a useful feature, but the other side
is that since any class can override these fake operators, reading
code like this: obj1 + obj2 opens up a world of possibility as to
what that can mean. Notice that except assignment and a few other
obvious operators, there appears to be a lot of fake operators that
we can override! This makes Ruby both powerful and potentially
dangerous. Let's explore how to use these fake operators in a sensible
way.
