# new_scope_per_method_call.rb
class C
  def x(value_for_a,recurse=false)
    a = value_for_a
    print "Here's the inspect-string for 'self':"
    p self

    puts "And here's a:"
    puts a

    if recurse
      puts "Calling myself (recursion)..."
      x("Second value for a")

      puts "Back after recursion; here's a:"
      puts a
    end

  end
end

c = C.new
c.x("First value for a", true)

=begin
OUTPUT:

# start of x:
Here's the inspect-string for 'self':#<C:0x00000000b58600>
And here's a:
First value for a

# starting new local scope for new method call
Calling myself (recursion)...
Here's the inspect-string for 'self':#<C:0x00000000b58600>
And here's a:
Second value for a

# back to first local scope:
Back after recursion; here's a:
First value for a

=end