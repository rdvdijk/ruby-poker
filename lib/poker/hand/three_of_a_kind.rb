module Poker
  class ThreeOfAKind < Hand
    attr_reader :three_rank, :kickers
    
    def initialize(cards)
      super
      @three_rank = same_rank(3)
      @set = get_by_count(3)
      @kickers = (cards - @set).sort
    end

    def self.is?(cards)
      Hand.kind?(cards, [1,1,3])
    end
    
    def to_s
      "ThreeOfAKind: #{@set.inspect} + #{@kickers.inspect}"
    end

    # compare the rank of the three of a kind
    # if the same: compare the other 2 cards
    def <=>(other)
      return super if self.class != other.class
      compare = Card::RANKS.index(@three_rank) <=> Card::RANKS.index(other.three_rank)
      return compare unless compare == 0
      compare_kickers(@kickers, other.kickers)
    end  
  end
end