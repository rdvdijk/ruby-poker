module Poker
  class TwoPair < Hand
    attr_reader :pairs, :kicker

    def initialize(cards)
      super
      @pairs = get_pairs.sort 
      @kicker = cards - @pairs
    end
  
    def self.is?(cards)
      Hand.kind?(cards, [1,2,2])
    end
  
    def to_s
      "TwoPairs: #{@pairs.inspect} + #{@kicker}"
    end

    # compare value of the pairs
    # if the same: compare kicker
    def <=>(other)
      return super if self.class != other.class
      @pairs.each_with_index do |card, i|
        compare = (other.pairs[i].value_compare card)
        return compare if compare != 0
      end
      compare_kickers(@kicker, other.kicker)
    end
  end
end