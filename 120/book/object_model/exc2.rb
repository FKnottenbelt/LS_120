module Cleverness
  def math_skills?
    [true,false].sample
  end
end

class Person
  include Cleverness
end

toby = Person.new
p toby.math_skills?