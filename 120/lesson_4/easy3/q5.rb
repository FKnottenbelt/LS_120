=begin
If I have the following class:

class Television
  def self.manufacturer
    # method logic
  end

  def model
    # method logic
  end
end

What would happen if I called the methods like shown below?

tv = Television.new
tv.manufacturer
tv.model

Television.manufacturer
Television.model
=end

class Television
  def self.manufacturer
    # method logic
  end

  def model
    # method logic
  end
end

tv = Television.new
tv.manufacturer # error
tv.model  # what ever is in model

Television.manufacturer # whatever is in manufacturer
Television.model  # error

# ls (wording)
=begin


If you attempted to call tv.manufacturer you would get an error and
it would look something like this undefined method manufacturer for
#<Television:XXXX>, this is because tv is an instance of the class
Television and manufacturer is a class method, meaning it can only
be called on the class itself (in this case Television).

You would also get an error if you tried to call Television.model,
the error would look something like NoMethodError: undefined method
'model' for Television:Class. This is because this method only exist
on an instance of the class Television in this case tv.

=end