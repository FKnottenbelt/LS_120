class ValidateAgeError < StandardError; end

begin
  def validate_age(age)
    raise ValidateAgeError, "invalid age" unless (0..105).include?(age)
  end
rescue ValidateAgeError => e
  # take action
end

validate_age(150)
# in `validate_age': invalid age (ValidateAgeError)
