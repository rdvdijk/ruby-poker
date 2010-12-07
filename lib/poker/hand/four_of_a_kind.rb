module Poker
  class FourOfAKind < RankedHand
    attr_reader :four_rank, :one_rank
    rank_counts [1,4]
    
    def initialize(cards)
      super
      @four_rank = same_rank(4)
      @one_rank = same_rank(1)
      @quad = get_by_count(4)
      @kicker = get_by_count(1)
    end

    def to_s
      "FourOfAKind #{@quad.inspect} + #{@kicker}"
    end

    # compare the rank of the four cards
    # if the same: compare the rank of the one card
    def <=>(other)
      return super if self.class != other.class
      four_compare = Card::RANKS.index(@four_rank) <=> Card::RANKS.index(other.four_rank)
      return four_compare unless four_compare == 0
      Card::RANKS.index(@one_rank) <=> Card::RANKS.index(other.one_rank)
    end
  end
end