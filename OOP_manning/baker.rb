# baker.rb

class Cake
  def initialize(batter)
    @batter = batter
    @baked = true
  end
end

class Egg
end

class Flour
end

class Baker
  def bake_cake
    @batter = []
    pour_flour
    add_egg
    stir_batter
    return Cake.new(@batter)
  end

  def pour_flour
    @batter.push(Flour.new)
  end

  def add_egg
    @batter.push(Egg.new)
  end

  def stir_batter
  end

  private :pour_flour, :add_egg, :stir_batter
end

tony = Baker.new
cake = tony.bake_cake
p cake
##<Cake:0x00000001243208 @batter=[#<Flour:0x00000001243258>,
#<Egg:0x00000001243230>], @baked=true>
tony.add_egg
#private method `add_egg' called for #<Baker:0x000000012432a8>
#(NoMethodError)
add_egg
#undefined local variable or method `add_egg' for main (self == main)
