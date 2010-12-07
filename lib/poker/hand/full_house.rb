module Poker
  class FullHouse < Hand
    attr_reader :three_rank, :two_rank
    
    def initialize(cards)
      super
      @three_rank = same_rank(3)
      @two_rank = same_rank(2)
      @three = get_by_count(3)
      @pair = get_by_count(2)
    end

    def self.is?(cards)
      Hand.kind?(cards, [2,3])
    end
    
    def to_s
      "FullHouse #{@three.inspect} + #{@pair.inspect}"
    end

    # compare the rank of the three cards
    # if the same: compare the rank of the two cards
    def <=>(other)
      return super if self.class != other.class
      three_compare = Card::RANKS.index(@three_rank) <=> Card::RANKS.index(other.three_rank)
      return three_compare unless three_compare == 0
      Card::RANKS.index(@two_rank) <=> Card::RANKS.index(other.two_rank)
    end
  end
end