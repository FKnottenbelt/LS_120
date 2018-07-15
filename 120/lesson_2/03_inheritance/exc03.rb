=begin
Draw a class hierarchy diagram of the classes from step #2
=end

class Animal
  def run
    'running!'
  end

  def jump
    'jumping!'
  end
end

class Dog < Animal
  def speak
    'bark!'
  end

  def swim
    'swimming!'
  end

  def fetch
    'fetching!'
  end
end

class Bulldog < Dog
  def swim
    "can't swim!"
  end
end

class Cat < Animal
  def speak
    'miaouw!'
  end
end

=begin
          animal
          =======
          run
          jump
dog                        cat
=====                      ======
speak                      speak
swim
fetch

bulldog
=======
swim

=end