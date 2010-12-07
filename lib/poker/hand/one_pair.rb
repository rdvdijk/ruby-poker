module Poker
  class OnePair < RankedHand
    attr_reader :pair, :kickers
    rank_counts [1,1,1,2]
    
    def initialize(cards)
      super
      @pair = get_by_count(2).sort 
      @kickers = (cards - @pair).sort
    end

    def to_s
      "OnePair: #{@pair.inspect} + #{@kickers.inspect}"
    end

    # compare the rank of the pair
    # if the same: compare the 3 kickers
    def <=>(other)
      return super if self.class != other.class
      @pair.each_with_index do |card, i|
        compare = (other.pair[i].rank_compare card)
        return compare if compare != 0
      end
      compare_kickers(@kickers, other.kickers)
    end
  end
end
