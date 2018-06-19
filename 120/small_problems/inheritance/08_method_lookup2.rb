# Using the following code, determine the lookup path used when invoking
# cat1.color. Only list the classes that were checked by Ruby when searching
# for the #color method.
# class Animal
# end

# class Cat < Animal
# end

# class Bird < Animal
# end

# cat1 = Cat.new('Black')
# cat1.color


class Animal
end

class Cat < Animal
end

class Bird < Animal
end

# cat1 = Cat.new('Black')
# cat1.color
p Cat.ancestors # goes through whole path, since method does not exist
# [Cat, Animal, Object, Kernel, BasicObject]