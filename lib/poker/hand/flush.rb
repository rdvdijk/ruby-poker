module Poker
  class Flush < Hand
    attr_reader :sorted_cards
    
    def initialize(cards)
      super
      @sorted_cards = @cards.to_a.sort
    end

    def self.is?(cards)
      cards.collect(&:suit).uniq.size == 1
    end
    
    def to_s
      "Flush #{sorted_cards.inspect}"
    end

    # compare the rank of the high cards
    def <=>(other)
      return super if self.class != other.class
      compare_kickers(@sorted_cards, other.sorted_cards)
    end
  end
end