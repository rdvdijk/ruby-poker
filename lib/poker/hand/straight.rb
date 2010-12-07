module Poker
  class Straight < Hand
    def initialize(cards)
      super
      @sorted_cards = cards.sort
    end
    
    # Difference between minimum and maximum card rank is 4, and is no
    # pair or set in the hand.
    def self.is?(cards)
      rank_positions = rank_positions(cards)
      return false if (rank_positions.max - rank_positions.min != 4)
      HighCards.is?(cards) # no pairs
    end
    
    def to_s
      "Straight #{@sorted_cards.inspect}"
    end

    # Compare the rank of the highest card.
    def <=>(other)
      return super if self.class != other.class
      rank_positions = Straight.rank_positions(@cards)
      other_positions = Straight.rank_positions(other.cards)
      rank_positions.max <=> other_positions.max
    end

    # Get the positions (=rank) of the cards, keeping a 5-high straight in mind.
    # A 9-high straight returns: [3,4,5,6,7]
    # A 5-hight straight returns: [-1,0,1,2,3]
    def self.rank_positions(cards)
      rank_positions = cards.inject([]) do |array,card|
        array << Card::RANKS.index(card.rank)
        array
      end

      # special case: Ace, change position to -1 if a '2' i present
      if rank_positions.include?(0) && rank_positions.include?(Card::RANKS.size-1)
        rank_positions[rank_positions.index(Card::RANKS.size-1)] = -1
      end
      
      rank_positions
    end
  end
end