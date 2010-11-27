module Poker
  class FourOfAKind < Hand
    attr_reader :four_value, :one_value
    
    def initialize(cards)
      super
      @four_value = same_value(4)
      @one_value = same_value(1)
    end

    def self.is?(cards)
      Hand.kind?(cards, [1,4])
    end

    # compare the value of the four cards
    # if the same: compare the value of the one card
    def <=>(other)
      return super if self.class != other.class
      four_compare = Card::VALUES.index(@four_value) <=> Card::VALUES.index(other.four_value)
      return four_compare unless four_compare == 0
      Card::VALUES.index(@one_value) <=> Card::VALUES.index(other.one_value)
    end
  end
end