# more_on_class_variables.rb
# https://stackoverflow.com/questions/15773552/ruby-class-instance-variable-vs-class-variable#15773671

class S
  @@k = 23
  @s = 15

  def self.s  # getter for class instance var. must be called by Class
    @s        # but this will only count S stuff
  end

  def self.k  # getter for class var must be called by Class
     @@k      # this will also count subclass stuff
  end

end
p S.s #15
p S.k #23
# will not work:
# o = S.new
# p o.s
# p o.k

#################

class Parent
  @things = []      # class instance var. for all things Parent

  def self.things   # it's a overal parent getter thing (class) so use self
    @things
  end

  def things        # this is getter for parent objects.(no self in def)
    self.class.things  # but call internal Parent thing method with
  end                  # self.class.<internal class method def-ed with self>
end

class Child < Parent
  @things = []      # class instance var. for all things Child
end

Parent.things << :car   # add stuff to all things Parent => class calls
Child.things  << :doll  # add stuff to all things Child => class calls
mom = Parent.new
dad = Parent.new

p Parent.things #=> [:car]
p Child.things  #=> [:doll]
p mom.things    #=> [:car]
p dad.things    #=> [:car]

##########################3

class Parent
  @@things = []    # class var. for all thing Parent and children
                   # and grand childeren and grand grand children etc

  def self.things  # it's a overal parent getter thing (class) so use self
    @@things
  end

  def things  # this is getter for parent objects.(no self in def)
    @@things
  end
end

class Child < Parent
end

Parent.things << :car
Child.things  << :doll

p Parent.things #=> [:car,:doll]
p Child.things  #=> [:car,:doll]

mom = Parent.new
dad = Parent.new
son1 = Child.new
son2 = Child.new
daughter = Child.new

[ mom, dad, son1, son2, daughter ].each{ |person| p person.things }
#=> [:car, :doll]
#=> [:car, :doll]
#=> [:car, :doll]
#=> [:car, :doll]
#=> [:car, :doll]

#########################################################
# putting it all together
#
class Parent
  @@family_things = []    # Shared between class and subclasses
  @shared_things  = []    # Specific to this Parent class

  def self.family_things # class getter thing, use self
    @@family_things
  end

  def self.shared_things  # class getter thing, use self
    @shared_things
  end

  attr_accessor :my_things  # object getter/setter
  def initialize
    @my_things = []       # Just for object
  end

  def family_things      # object getter (calling class method)
    self.class.family_things
  end

  def shared_things     # object getter (calling class method)
    self.class.shared_things
  end
end

class Child < Parent
  @shared_things = []  # Specific to this child class
end

mama = Parent.new
papa = Parent.new
joey = Child.new
suzy = Child.new

Parent.family_things << :house
papa.family_things   << :vacuum
mama.shared_things   << :car
papa.shared_things   << :blender
papa.my_things       << :quadcopter
joey.my_things       << :bike
suzy.my_things       << :doll
joey.shared_things   << :puzzle
suzy.shared_things   << :blocks

p Parent.family_things #=> [:house, :vacuum]
p Child.family_things  #=> [:house, :vacuum]
p papa.family_things   #=> [:house, :vacuum]
p mama.family_things   #=> [:house, :vacuum]
p joey.family_things   #=> [:house, :vacuum]
p suzy.family_things   #=> [:house, :vacuum]

p Parent.shared_things #=> [:car, :blender]
p papa.shared_things   #=> [:car, :blender]
p mama.shared_things   #=> [:car, :blender]
p Child.shared_things  #=> [:puzzle, :blocks]
p joey.shared_things   #=> [:puzzle, :blocks]
p suzy.shared_things   #=> [:puzzle, :blocks]

p papa.my_things       #=> [:quadcopter]
p mama.my_things       #=> []
p joey.my_things       #=> [:bike]
p suzy.my_things       #=> [:doll]