# Below we have 3 classes: Student, Graduate, and Undergraduate. Some details
# for these classes are missing. Make changes to the classes below so that the
# following requirements are fulfilled:
#
# Graduate students have the option to use on-campus parking, while
# Undergraduate students do not.
#
# Graduate and Undergraduate students have a name and year associated
# with them.
#
# Note, you can do this by adding or altering no more than 5 lines of code.
#
# class Student
#   def initialize(name, year)
#     @name = name
#     @year = year
#   end
# end
#
# class Graduate
#   def initialize(name, year, parking)
#   end
# end
#
# class Undergraduate
#   def initialize(name, year)
#   end
# end

class Student
  def initialize(name, year)
    @name = name
    @year = year
  end
end

class Graduate < Student # 2
  def initialize(name, year, parking)
    @parking = parking # 5
    super # 3
  end
end

class Undergraduate < Student # 1
  def initialize(name, year)
    super # 4
  end
end

=begin
Further Exploration

There is one other "form" of the keyword super. We can call it
as super(). This calls the superclass method of the same name as
the calling method, but here no arguments are passed to the superclass
method at all.

Can you think of a way to use super() in another Student related class?
=end