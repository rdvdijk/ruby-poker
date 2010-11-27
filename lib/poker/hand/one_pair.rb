module Poker
  class OnePair < Hand
    attr_reader :pair, :kickers
    
    def initialize(cards)
      super
      @pair = get_pairs.sort 
      @kickers = (cards - @pair).sort
    end

    def self.is?(cards)
      Hand.kind?(cards, [1,1,1,2])
    end

    # compare the value of the pair
    # if the same: compare the 3 kickers
    def <=>(other)
      return super if self.class != other.class
      @pair.each_with_index do |card, i|
        compare = (other.pair[i].value_compare card)
        return compare if compare != 0
      end
      compare_kickers(@kickers, other.kickers)
    end
  end
end