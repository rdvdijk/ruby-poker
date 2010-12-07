module Poker
  class HighCards < RankedHand
    attr_reader :sorted_cards
    rank_counts [1,1,1,1,1]
    
    def initialize(cards)
      super
      @sorted_cards = @cards.to_a.sort
    end
    
    def to_s
      "HighCards: #{sorted_cards.inspect}"
    end
  
    # compare the highest cards
    def <=>(other)
      return super if self.class != other.class
      compare_kickers(@sorted_cards, other.sorted_cards)
    end
  end
end