module Poker
  class RankedHand < Hand
    def self.rank_counts(counts)
      singleton_class.send(:define_method, :is?) { |cards|
        RankedHand.kind?(cards, counts)
      }
    end
    
    # Get paired cards.
    def get_by_count(probe)
      pair_info = Hash[@rank_count.select {|rank, count| count==probe }]
      pair_cards = cards_by_rank(pair_info.keys)
    end
    
    # Select cards in hand of given ranks.
    def cards_by_rank(ranks)
      @cards.select { |card| ranks.include?(card.rank) }
    end
    
    # Collect cards by rank count (return first found).
    def same_rank(same)
      @rank_count.select {|rank, count| count==same }.first[0]
    end

    # http://www.ruby-forum.com/topic/89101#171173
    # Compare values of two arrays. (e.g. [1,1,2] == [2,1,1])
    def self.kind?(cards, wanted)
      found = Hand.rank_count(cards).values
      found.sort_by{|n| n.hash} == wanted.sort_by {|n|n.hash}
    end
   
    # Generic compare for ranked hands:
    #  - From most counted cards to less counted cards
    #  - Compare rank with other hand's rank
    #
    # def <=>(other)
    #   return super if self.class != other.class
    #   @pair.each_with_index do |card, i|
    #     compare = (other.pair[i].rank_compare card)
    #     return compare if compare != 0
    #   end
    #   compare_kickers(@kickers, other.kickers)
    # end
    
  end
end