# Assignment: Some Improvements

## 1 - clear screen method
While the code from our initial exploration seems to work, and the
classes we created seem agreeable, there are some areas in the code
that we should improve on before moving forward.

- We use system "clear" to clear the screen. Suppose we want to
  change this to some other command in the future - we'd have to
  change it in multiple places. Create a clear method and call this
  new method instead of system "clear".

##### possible solution:
```ruby
class TTTGame
  # ... rest of class omitted for brevity

  def clear
    system "clear"
  end
end
```
This method name, however, collides with the local variable in
display_board. Since the scope of the local variable is only within
the method, let's rename that.

```ruby
def display_board(clear_screen = true)
  clear if clear_screen

  # ... rest of method omitted for brevity
end
```

## 2 - display_board(clear_screen: false)
The first time we display a board, we want to suppress the clearing
of the screen. This is so we can see the welcome message, or the
play again message. However, the method invocation,
display_board(false) is incredibly vague. Six months from now,
no one will remember what that false stands for without looking
at the method implementation. Let's change the method so that we
can invoke it like this: display_board(clear_screen: false).

=> so we need to put in a hash with a key :clear_screen and a
value of true or false.
I know how to do that if screen is a class..

The trick is:
```ruby
display_board(clear_screen: false)

def display_board(options = { clear_screen: true })
    clear_screen if options[:clear_screen]
end
```

##### possible solution:
```ruby
def display_board(options = { clear_screen: true })
  clear if options[:clear_screen]

  # ... rest of method omitted for brevity
end
```

Note that when we invoke the method, we can do any of the
following:

method invocation |	effect
--|--
display_board | the options hash will be set to the default hash, {clear_screen: true}
display_board({clear_screen: false}) |	options will be replaced by the hash in the argument, {clear_screen: false}
display_board(clear_screen: false)|	same effect as above, despite the missing {}
display_board clear_screen: false |	same effect as above, despite the missing {} and missing ()
display_board(a: 1, b: 2) |	same effect as above, except the options hash will now be set to {a: 1, b: 2}. Surprisingly, this works for our method since we're just calling options[:clear_screen], which in this case will return nil (and be evaluated as false)

Now that we can call display_board(clear_screen: false), we stand
a much better chance at remembering what this method does in the
future. The code is almost self documenting.
