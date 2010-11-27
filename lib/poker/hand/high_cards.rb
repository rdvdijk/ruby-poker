module Poker
  class HighCards < Hand
    attr_reader :sorted_cards
    
    def initialize(cards)
      super
      @sorted_cards = @cards.to_a.sort
    end
    
    def self.is?(cards)
      Hand.kind?(cards, [1,1,1,1,1])
    end
  
    # compare the highest cards
    def <=>(other)
      return super if self.class != other.class
      compare_kickers(@sorted_cards, other.sorted_cards)
    end
  end
end