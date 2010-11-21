class Player
  attr_reader :name
  attr_reader :hand
  
  def initialize(name)
    @name = name
    @hand = Hand.new
  end
  
  def give_card(card)
    @hand << card
  end
  
  def fold
    @hand.fold
  end
  
  def folded?
    @hand.empty?
  end
  
end