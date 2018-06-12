class Student
  attr_accessor :name
  attr_writer :grade

  def initialize(name)
    @name = name
  end

  def public_grade
    puts "#{name} grade is #{grade}"
  end

  def better_grade_than?(student)
    grade > student.grade
  end

  protected

  attr_reader :grade

end

bob = Student.new('Bob')
bob.grade = 4
puts bob
#p bob.grade
puts bob.public_grade
joe = Student.new('Joe')
joe.grade = 8
puts joe.public_grade
puts "Well done!" if joe.better_grade_than?(bob)