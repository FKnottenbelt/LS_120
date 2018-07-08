# Now that we have a Walkable module, we are given a new challenge.
# Apparently some of our users are nobility, and the regular way of
# walking simply isn't good enough. Nobility need to strut.
#
# We need a new class Noble that shows the title and name when walk
# is called:
#
# byron = Noble.new("Byron", "Lord")
# p byron.walk
# # => "Lord Byron struts forward"
#
# We must have access to both name and title because they are needed for
# other purposes that we aren't showing here.
#
# byron.name
# => "Byron"
# byron.title
# => "Lord"


# Approach/Algorithim
#
# The easiest way to accomplish this is to provide a method that returns
# both the title and name objects of the Noble class, and just the name
# for other classes.

module Walkable
  def walk
    puts "#{self} #{gait} forward"  # calling self instead of name
  end
end

class Person
  include Walkable

  attr_reader :name

  def initialize(name)
    @name = name
  end

  def to_s  # self == name
    name
  end

  private

  def gait
    "strolls"
  end
end


class Noble
  include Walkable

  attr_reader :name, :title

  def initialize(name, title)
    @name = name
    @title = title
  end

  def to_s
    "#{title} #{name}"
  end

  private

  def gait
    "struts"
  end
end

mike = Person.new("Mike")
mike.walk
# => "Mike strolls forward"

byron = Noble.new("Byron", "Lord")
byron.walk
# => "Lord Byron struts forward"
p byron.name
#=> "Byron"
p byron.title
#=> "Lord"