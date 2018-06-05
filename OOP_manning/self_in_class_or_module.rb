class C
  puts "Just started class C:"
  puts self  # C
  module M
    puts "Nested module C::M:"
    puts self # C::M
  end
  puts "Back in the outer level of C:"
  puts self # C
end
