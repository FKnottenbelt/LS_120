# Assignment: Some Improvements

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

