module Poker
  class RankedHand < Hand

    def initialize(cards)
      super
      @rank_count = RankedHand.rank_count(cards)
    end
  
    def self.rank_counts(counts)
      @counts = counts
    end
    
    def self.is?(cards)
      RankedHand.kind?(cards, @counts)
    end
    
    # Get paired cards. (note: only used for to_s)
    def get_by_count(probe)
      pair_info = Hash[@rank_count.select {|rank, cards| cards.length==probe }]
      pair_cards = cards_by_rank(pair_info.keys)
    end
    
    # Select cards in hand of given ranks.
    def cards_by_rank(ranks)
      @cards.select { |card| ranks.include?(card.rank) }
    end
    
    # Collect cards by rank count (return first found).
    def same_rank(same)
      @rank_count.select {|rank, cards| cards.length == same }.first[0]
    end

    # http://www.ruby-forum.com/topic/89101#171173
    # Compare values of two arrays. (e.g. [1,1,2] == [2,1,1])
    def self.kind?(cards, wanted)
      found = RankedHand.rank_count(cards).values.collect(&:length)
      found.sort_by{|n| n.hash} == wanted.sort_by {|n|n.hash}
    end
   
    # Generic compare for ranked hands:
    #  - From most counted cards to less counted cards
    #  - Compare rank with other hand's rank
    #
    # def <=>(other)
    # end
    
    private
 
    def self.rank_count(cards)      
      # rank_count = cards.inject(Hash.new(0)) do |hash,card| 
      #   hash[card.rank] += 1
      #   hash
      # end
      # p rank_count
      # rank_count
      cards.group_by(&:rank)
    end
  end
end