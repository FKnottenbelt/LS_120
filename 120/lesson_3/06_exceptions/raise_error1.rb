def validate_age(age)
  raise("invalid age") unless (0..105).include?(age)
end

validate_age(150)