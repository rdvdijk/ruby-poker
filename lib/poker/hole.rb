class Hole
  attr_reader :cards
  
  def initialize
    @cards = []
  end
  
  def <<(card)
    raise "A hole has 2 cards" if @cards.size >= 2
    @cards << card
  end
  
  def include?(card)
    @cards.include? card
  end
  
  def empty?
    @cards.empty?
  end
  
  def dealt?
    @cards.size == 2
  end
  
  def fold
    @cards.clear
  end
  
end