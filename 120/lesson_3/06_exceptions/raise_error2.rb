begin
  def validate_age(age)
    raise("invalid age") unless (0..105).include?(age)
    puts "valid age is #{age}"
  end
rescue RuntimeError => e
  puts e.message              #=> "invalid age"
end

validate_age(15)
validate_age(150)
