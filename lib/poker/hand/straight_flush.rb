module Poker
  class StraightFlush < Hand
    attr_reader :sorted_cards
    
    def initialize(cards)
      super
      @sorted_cards = @cards.to_a.sort
    end

    def self.is?(cards)
      Straight.is?(cards) && Flush.is?(cards)
    end
    
    def to_s
      "StraightFlush: #{@sorted_cards.inspect}"
    end

    # compare the value of the highest card
    def <=>(other)
      return super if self.class != other.class
      compare_kickers(@sorted_cards, other.sorted_cards)
    end
  end
end