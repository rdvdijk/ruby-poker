# The seven cards, 5 of which make the actual hand
class Hand
  attr_reader :cards
  
  def initialize(cards, hole)
    @cards = cards + hole.cards
  end
  
  def <=>(other)
    # TODO: poker hand logic goes here
    
    # one way:
    #   http://nsayer.blogspot.com/2007/07/algorithm-for-evaluating-poker-hands.html
    # or a big table of all hands:
    #   http://www.suffecool.net/poker/evaluator.html
    # round-up:
    #   http://www.codingthewheel.com/archives/poker-hand-evaluator-roundup
    
    # dummy:
    @cards.last.to_s <=> other.cards.last.to_s
  end
  
  def to_s
    puts @cards.join(" ")
  end  
end