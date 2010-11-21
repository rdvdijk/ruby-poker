# The seven cards, 5 of which make the actual hand
class Hand
  attr_reader :cards
  
  def initialize(cards, hole)
    @cards = cards + hole.cards
  end
  
  def <=>(other)
    # TODO: poker hand logic goes here
    @cards.last.to_s <=> other.cards.last.to_s
  end
  
  def to_s
    puts @cards.join(" ")
  end  
end