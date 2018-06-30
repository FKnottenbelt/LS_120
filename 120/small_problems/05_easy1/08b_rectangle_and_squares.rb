# experimenting with different solutions

# no 1: template methods: can't be done, there is no default.
# no 2: hook messages
class Rectangle
  def initialize(args={})
    @height = args[:height]
    @width = args[:width]

    post_initialize(args)
  end

  def post_initialize(args)
    nil
  end

  def area
    @height * @width
  end
end

class Square < Rectangle

  def post_initialize(args)
    @width = args[:side]
    @height = args[:side]
  end

end

square = Square.new(side: 5)
puts "area of square = #{square.area}"
rec = Rectangle.new(width: 3, height: 2)
puts "area of rectangle = #{rec.area}"