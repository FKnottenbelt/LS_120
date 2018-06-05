# class_variables_hierarchy.rb

class Parent
  @@value = 100
end

class Child < Parent
  @@value = 200

  def show_value
    puts @@value
  end
end

class Parent
  puts @@value
end

# => 200

pete = Child.new
pete.show_value # => 200

