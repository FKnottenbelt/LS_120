=begin
Further Exploration

Add your own name and pets to this project.

Suppose the shelter has a number of not-yet-adopted pets, and wants to
manage them through this same system. Thus, you should be able to add the
following output to the example output shown above:

The Animal Shelter has the following unadopted pets:
a dog named Asta
a dog named Laddie
a cat named Fluffy
a cat named Kat
a cat named Ben
a parakeet named Chatterbox
a parakeet named Bluebell
   ...

P Hanson has 3 adopted pets.
B Holmes has 4 adopted pets.
The Animal shelter has 7 unadopted pets.
=end


class Pet
  attr_reader :name, :race
  def initialize(race, name)
    @race = race
    @name = name
  end

  def to_s
    "a #{race} named #{name}"
  end
end

class Owner
  attr_reader :name, :pets

  def initialize(name)
    @name = name
    @pets = []
  end

  def number_of_pets
    pets.size
  end

  def pets=(pet)
    @pets << pet
  end

  def print_pets
    @pets.each do |pet|
      puts pet
    end
  end
end

class Shelter
  def initialize()
    @owners = []
    @unadopted_pets = []
  end

  def adopt(owner, pet)
    owner.pets = pet
    @owners << owner if !@owners.include?(owner)
    @unadopted_pets.delete(pet)
  end

  def rescue_pet(pet)
    @unadopted_pets << pet
  end

  def print_adoptions
    @owners.each do |owner|
      puts "#{owner.name} has adopted the following pets:"
      owner.print_pets
      puts
    end
  end

  def print_unadopted_pets
    puts "The Animal Shelter has the following unadopted pets:"
    @unadopted_pets.each do |pet|
      puts pet
    end
    puts
  end

  def number_of_unadopted_pets
    @unadopted_pets.size
  end
end

butterscotch = Pet.new('cat', 'Butterscotch')
pudding      = Pet.new('cat', 'Pudding')
darwin       = Pet.new('bearded dragon', 'Darwin')
kennedy      = Pet.new('dog', 'Kennedy')
sweetie      = Pet.new('parakeet', 'Sweetie Pie')
molly        = Pet.new('dog', 'Molly')
chester      = Pet.new('fish', 'Chester')

ashta        = Pet.new('dog', 'Ashta')
laddie       = Pet.new('dog', 'Laddie')

phanson = Owner.new('P Hanson')
bholmes = Owner.new('B Holmes')

shelter = Shelter.new
shelter.rescue_pet(ashta)
shelter.rescue_pet(laddie)
shelter.rescue_pet(butterscotch)
shelter.adopt(phanson, butterscotch)
shelter.adopt(phanson, pudding)
shelter.adopt(phanson, darwin)
shelter.adopt(bholmes, kennedy)
shelter.adopt(bholmes, sweetie)
shelter.adopt(bholmes, molly)
shelter.adopt(bholmes, chester)
shelter.print_adoptions
shelter.print_unadopted_pets
puts "#{phanson.name} has #{phanson.number_of_pets} adopted pets."
puts "#{bholmes.name} has #{bholmes.number_of_pets} adopted pets."
puts "The Animal shelter has #{shelter.number_of_unadopted_pets} unadopted pets."
