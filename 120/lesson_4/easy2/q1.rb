=begin
You are given the following code:

class Oracle
  def predict_the_future
    "You will " + choices.sample
  end

  def choices
    ["eat a nice lunch", "take a nap soon", "stay at work late"]
  end
end

What is the result of calling

oracle = Oracle.new
oracle.predict_the_future

=end

class Oracle
  def predict_the_future
    "You will " + choices.sample
  end

  def choices
    ["eat a nice lunch", "take a nap soon", "stay at work late"]
  end
end

oracle = Oracle.new
p oracle.predict_the_future
# "You will eat a nice lunch"
# "You will take a nap soon" etc


# ls (correct wording)
# Each time you call, a string is returned which will be of the form
# "You will <something>" where the something is one of the 3 phrases
# defined in the get_choices array. The specific string will be chosen
# randomly.