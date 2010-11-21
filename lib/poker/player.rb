class Player
  attr_reader :name
  attr_reader :hole
  
  def initialize(name)
    @name = name
    @hole = Hole.new
  end
  
  def give_card(card)
    @hole << card
  end
  
  def fold
    @hole.fold
  end
  
  def dealt?
    @hole.dealt?
  end
  
  def folded?
    @hole.empty?
  end
  
  def playing?
    !folded?
  end
end