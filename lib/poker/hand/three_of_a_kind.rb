module Poker
  class ThreeOfAKind < Hand
    attr_reader :three_value
    
    def initialize(cards)
      super
      @three_value = same_value(3)
    end

    def self.is?(cards)
      Hand.kind?(cards, [1,1,3])
    end
    
    def to_s
      "ThreeOfAKind: #{three_value}"
    end

    # compare the value of the three of a kind
    # if the same: compare the other 2 cards
    def <=>(other)
      return super if self.class != other.class
      Card::VALUES.index(@three_value) <=> Card::VALUES.index(other.three_value)
    end  
  end
end