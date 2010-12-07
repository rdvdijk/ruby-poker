module Poker
  class TwoPair < RankedHand
    attr_reader :pairs, :kicker
    rank_counts [1,2,2]

    def initialize(cards)
      super
      @pairs = get_by_count(2).sort 
      @kicker = cards - @pairs
    end
  
    def to_s
      "TwoPairs: #{@pairs.inspect} + #{@kicker}"
    end

    # compare rank of the pairs
    # if the same: compare kicker
    def <=>(other)
      return super if self.class != other.class
      @pairs.each_with_index do |card, i|
        compare = (other.pairs[i].rank_compare card)
        return compare if compare != 0
      end
      compare_kickers(@kicker, other.kicker)
    end
  end
end