# Rubocop: Assignment Branch Condition Size

You should always examine any complexity complaints that Rubocop issues,
and, in most cases, refactor the code to simplify it.
But not if that makes it unreadable (in that case disable the cop in the
code for that method)

You can resolve most complexity complaints by refactoring the method:
identify and remove repetitive code or break it down into smaller logical
tasks. This approach works well in most cases, but with one complexity
complaint in particular - `the Assignment Branch Condition size or
AbcSize` -- refactoring can be harder than you might think. Before
tackling an AbcSize complaint, you should first identify the
characteristics of the method that triggered the AbcSize complaint.
To do that, you need to know how to calculate the AbcSize for a method.

You don't have to memorize this information. Bookmark it, though, so
you can refer to it the next time you get an AbcSize complaint.

The `AbcSize COP` is a code complexity warning that counts the
assignments, branches (aka, method calls), and conditions in a method,
then reduces those numbers to a single value - a metric - that describes
the complexity. (The larger the AbcSize, the more complex the code.).
`To derive this metric, Rubocop counts the assignments (call this value
a), branches (b), and conditions (c) in your method.` It then computes
the result using the formula:

    abc_size = Math.sqrt(a**2 + b**2 + c**2)

If the resulting value is greater than 18 (the default), Rubocop flags
the method as too complex. That's all there is to it.

If your code has six assignments, 16 branches (method calls), and
seven conditions, then the AbcSize is Math.sqrt(6**2 + 16**2 + 7**2),
or 18.47 -- that's a hair over the trigger level of 18. Your goal is
to change that number to something less than 18. To do that, you have
to reduce one or more of these components. In this example, eliminating
a single method call drops the AbcSize down to 17.6, enough to silence
Rubocop.

Hint: focus on the component with the greatest count - reducing the
occurrences of the most frequent type has the most effect on the
computed AbcSize. In the example above, we chose to focus on reducing
branches since we have more branches than either assignments or
conditions.

#### Calculating the AbcSize
Calculating the AbcSize is not hard: count each component type, and
plug each total into the formula. The tricky part comes in counting
the different items.

Counting `assignments` is easy enough: most anything that looks like
variable = some_expression is an assignment, as is
variable += some_expression, variable -= some_expression, and so on.
Be careful, though: something like hash[key] = value isn't an
assignment - it's a method call (a branch) since the Hash class
defines a #[]= method. You can often reduce assignments in your
method by looking for repetitive assignments, or by removing
intermediate values (be careful though; this may reduce readability).

`Conditions` counts are easy too: a condition is any point in the
code where execution can take 2 or more different paths: any code
that tests the truthiness of an expression to determine what the
program should do. For example:
```ruby
if a == 1
  do_this
elsif b == 2 || c.empty?
  do_that
end
puts final_result

```
This code has 3 conditions: `a == 1`, `b == `2, and `c.empty?`.
After evaluating `a == 1`, execution can go to either line 2 or line 3.
After evaluating `b == 2`, execution can go to either `c.empty?` or
line 4. After evaluating `c.empty?`, execution can either go to line
4 or line 6.

The most effective ways to reduce the condition count are to refactor
repetitive conditions and complicated conditional expressions. The
latter is as simple as giving a condition a name and putting it in
a method. For instance, rewrite:

```ruby
if move1 == "rock" && (move2 == "scissors" || move2 == "lizard"))...
```
as:

```ruby
def rock_wins?(move1, move2)
  move1 == "rock" && (move2 == "scissors" || move2 == "lizard"))
end

if rock_wins?(move1, move2)...
```

Counting `branches`, or method calls, can be tricky. Ruby hides
a lot of method calls behind syntax. For example, `a[3]` is a method
call, as is `a[3] = 4`. Both expressions are branches. Many Ruby
operators are methods in disguise, such as +, *, ==, >, etc., and
all contribute to the branch count in a method.

Also, nearly every statement in Ruby involves a method call. puts
is a method. Array#each is a method. loop is a method. All add up
and contribute to the number of branches.

In OOP Ruby, you must also contend with getters and setters: every
reference to a getter or setter method in your class is a method
call.

For example:
```ruby
class Example
  attr_reader :something
  def initialize
    @something = [...]
  end
  def print_something
    if something.size == 0
      puts "something has just 1 item: #{something[0]}"
    elsif something.size == 1
      puts "something has 2 items: #{something[0]} #{something[1]}"
    else
      puts "something has #{something.size} items: #{something.join(' ')}"
    end
  end
end

```
Rubocop will complain about the Abc size for print_something,
primarily due to the number of branches. We call the something getter
seven times, and the [] method on something three times. We also
call #== twice, puts three times, #size three times, and #join
once. Together, that's 19 branches, which, along with the two
conditions, yields a metric of 19.1 points.

A simple fix for this code is to remove the calls to the something
getter by accessing @something directly, or by saving something to
a local variable, and then using it instead of the getter.
```
value = something
if value.size == 0
  ...
```

Using @something directly removes seven method calls while using
value drops six calls (but adds one assignment). Either way, it
reduces the AbcSize well below the trigger point for the COP.

One thing to consider in the print_something example is whether
silencing the AbcSize violation is worth the effort. One could a
rgue that the change isn't an improvement, so you're writing code
to keep Rubocop happy rather than writing exemplary code. Others
will argue that making this change is a small tradeoff for
eliminating the Rubocop complaint and saving future developers
from having to make their own determination; the alternative is
to use `# rubocop:disable` and `# rubocop:enable` comments in your
code to silence Rubocop.

# Conclusion
The right answer is up to you, but don't ignore Rubocop because
you don't want to deal with it or can't see an easy solution.
Make a decision based on whether the refactored code is better than
the original.

The point here is that, when faced with an AbcSize complaint,
you should:

    try to simplify your code.
    examine the results.
    use your best judgment.
