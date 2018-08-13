=begin

Circular Queue

https://en.wikipedia.org/wiki/Circular_buffer

A circular queue is a collection of objects stored in a buffer that is
treated as though it is connected end-to-end in a circle. When an object
is added to this circular queue, it is added to the position that immediately
follows the most recently added object, while removing an object always
removes the object that has been in the queue the longest.

This works as long as there are empty spots in the buffer. If the buffer
becomes full, adding a new object to the queue requires getting rid of an
existing object; with a circular queue, the object that has been in the queue
the longest is discarded and replaced by the new object.

Assuming we have a circular queue with room for 3 objects, the circular
queue looks and acts like this:

P1 	P2 	P3 	Comments
			      All positions are initially empty
1 			    Add 1 to the queue
1 	2 		  Add 2 to the queue
	  2 		  Remove oldest item from the queue (1)
	  2 	3 	Add 3 to the queue
4 	2 	3 	Add 4 to the queue, queue is now full
4 		  3 	Remove oldest item from the queue (2)
4 	5 	3 	Add 5 to the queue, queue is full again
4 	5 	6 	Add 6 to the queue, replaces oldest element (3)
7 	5 	6 	Add 7 to the queue, replaces oldest element (4)
7 		  6 	Remove oldest item from the queue (5)
7 			    Remove oldest item from the queue (6)
			      Remove oldest item from the queue (7)
		       	Remove non-existent item from the queue (nil)

Your task is to write a CircularQueue class that implements a circular
queue for arbitrary objects. The class should obtain the buffer size with
an argument provided to CircularQueue::new, and should provide the following
methods:

-  enqueue to add an object to the queue
-  dequeue to remove (and return) the oldest object in the queue. It should
   return nil if the queue is empty.

You may assume that none of the values stored in the queue are nil
(however, nil may be used to designate empty spots in the buffer).

Examples:
queue = CircularQueue.new(3)
puts queue.dequeue == nil

queue.enqueue(1)
queue.enqueue(2)
puts queue.dequeue == 1

queue.enqueue(3)
queue.enqueue(4)
puts queue.dequeue == 2

queue.enqueue(5)
queue.enqueue(6)
queue.enqueue(7)
puts queue.dequeue == 5
puts queue.dequeue == 6
puts queue.dequeue == 7
puts queue.dequeue == nil

queue = CircularQueue.new(4)
puts queue.dequeue == nil

queue.enqueue(1)
queue.enqueue(2)
puts queue.dequeue == 1

queue.enqueue(3)
queue.enqueue(4)
puts queue.dequeue == 2

queue.enqueue(5)
queue.enqueue(6)
queue.enqueue(7)
puts queue.dequeue == 4
puts queue.dequeue == 5
puts queue.dequeue == 6
puts queue.dequeue == 7
puts queue.dequeue == nil

The above code should display true 15 times.
=end

class CircularQueue
  attr_accessor :queue
  attr_reader :max_buffer

  def initialize(buffer_size)
    @queue = []
    @max_buffer = buffer_size
  end

  def enqueue(n)
    if queue.size < max_buffer
      queue.unshift(n)
    else
      dequeue
      queue.unshift(n)
    end
  end

  def dequeue
    queue.pop
  end

end

queue = CircularQueue.new(3)
puts queue.dequeue == nil

queue.enqueue(1)
queue.enqueue(2)
puts queue.dequeue == 1

queue.enqueue(3)
queue.enqueue(4)
puts queue.dequeue == 2

queue.enqueue(5)
queue.enqueue(6)
queue.enqueue(7)
puts queue.dequeue == 5
puts queue.dequeue == 6
puts queue.dequeue == 7
puts queue.dequeue == nil

queue = CircularQueue.new(4)
puts queue.dequeue == nil

queue.enqueue(1)
queue.enqueue(2)
puts queue.dequeue == 1

queue.enqueue(3)
queue.enqueue(4)
puts queue.dequeue == 2

queue.enqueue(5)
queue.enqueue(6)
queue.enqueue(7)
puts queue.dequeue == 4
puts queue.dequeue == 5
puts queue.dequeue == 6
puts queue.dequeue == 7
puts queue.dequeue == nil


# ls Solution
=begin
class CircularQueue
  def initialize(size)
    @buffer = [nil] * size
    @next_position = 0
    @oldest_position = 0
  end

  def enqueue(object)
    unless @buffer[@next_position].nil?
      @oldest_position = increment(@next_position)
    end

    @buffer[@next_position] = object
    @next_position = increment(@next_position)
  end

  def dequeue
    value = @buffer[@oldest_position]
    @buffer[@oldest_position] = nil
    @oldest_position = increment(@oldest_position) unless value.nil?
    value
  end

  private

  def increment(position)
    (position + 1) % @buffer.size
  end
end

Discussion

If you read the Wiki page on circular queues, it's likely that your
solution resembles ours in terms of mechanics: we have a buffer with room
for N objects, a pointer to the oldest object currently in the buffer,
and a pointer to the next spot where a new object will be inserted. We
also use nils to indicate empty buffer positions. All 3 of these items
are initialized in #initialize.

With this type of structure, our two pointers need to "wrap around" from
the final position to position 0. This is accomplished with our private
#increment method which simply increments the position pointer, and wraps
around to 0 when necessary.

The #enqueue method first checks whether it will be adding the option to
an empty buffer position or replacing an object in an occupied position.
If the position is occupied, we need to update the @oldest_position
pointer since we will be replacing the oldest object. Finally, we store
the object in the appropriate position, and increment the @next_position
pointer.

Note that #enqueue needs to test for nil, not just falseness. This is
because the queue may contain boolean values, so testing for falseness
would catch false values.

#dequeue starts by extracting the oldest object, and replacing it with
nil to indicate that the position is no longer occupied. Then we update
the @oldest_positiion pointer, and return the value that was originally
in that position.

The use of unless value.nil? in #dequeue is necessary to prevent problems
with calling #dequeue on an empty queue, and subsequently adding objects
to that queue. If you don't check for the nil value, the two pointers ge
t out of sync and cause problems.

###
Further Exploration

Phew. That's a lot of work, but it's a perfectly acceptable solution to
this exercise. However, there is a simpler solution that uses an Array,
and the #push and #shift methods. See if you can find a solution that does
this. And no, syou're not allowed to monkey-patch the Array class, though
doing so may help you determine what needs to be done.

monkeypatching: https://www.culttt.com/2015/06/17/what-is-monkey-patching-in-ruby/
=end