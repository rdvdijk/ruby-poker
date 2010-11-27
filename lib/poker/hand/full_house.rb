module Poker
  class FullHouse < Hand
    attr_reader :three_value, :two_value
    
    def initialize(cards)
      super
      @three_value = same_value(3)
      @two_value = same_value(2)
    end

    def self.is?(cards)
      Hand.kind?(cards, [2,3])
    end

    # compare the value of the three cards
    # if the same: compare the value of the two cards
    def <=>(other)
      return super if self.class != other.class
      three_compare = Card::VALUES.index(@three_value) <=> Card::VALUES.index(other.three_value)
      return three_compare unless three_compare == 0
      Card::VALUES.index(@two_value) <=> Card::VALUES.index(other.two_value)
    end
  end
end