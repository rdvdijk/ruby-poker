# The seven cards, 5 of which make the actual hand
require 'set'
module Poker
  class Hand
    attr_reader :cards
  
    ORDER = [:StraightFlush, :FourOfAKind, :FullHouse, :Flush, :Straight, :ThreeOfAKind, :TwoPair, :OnePair, :HighCards]

    def initialize(cards)
      @cards = cards.to_set
    end

    def <=>(other)
      @cards.last.to_s <=> other.cards.last.to_s
    end
  
    def self.determine_hand(cards, hole)
      hands = (hole.cards.to_a + cards).combination(5).collect { |cards| Hand.create(cards) }
    end

    def self.create(cards)
      ORDER.each do |hand|
        if const_get(hand).is?(cards)
          return const_get(hand).new(cards)
        end
      end
    end
  
    def to_s
      @cards.inspect
    end
    
    def inspect
      self.class.to_s + ":" + to_s
    end
  
    private
  
    def self.kind_count(cards)
      kind_count = cards.inject(Hash.new(0)) do |hash,card| 
        hash[card.value] += 1
        hash
      end
      kind_count.values
    end
    
    def self.kind?(cards, wanted)
      found = Hand.kind_count(cards)
      found.sort_by{|n| n.hash} == wanted.sort_by {|n|n.hash}
    end
  
  end
  
  #
  # All hand types:
  #

  class StraightFlush < Hand
    def self.is?(cards)
      Straight.is?(cards) && Flush.is?(cards)
    end
  end

  class FourOfAKind < Hand
    def self.is?(cards)
      Hand.kind?(cards, [1,4])
    end
  end

  class FullHouse < Hand
    def self.is?(cards)
      Hand.kind?(cards, [2,3])
    end
  end

  class Flush < Hand
    def self.is?(cards)
      cards.collect(&:suit).uniq.size == 1
    end
  end

  class Straight < Hand
    # find positions in ordered values array, 
    # difference between min and max should be exactly 5
    def self.is?(cards)
      value_positions = cards.inject([]) do |array,card|
        array << Card::VALUES.index(card.value)
        array
      end

      # special case: Ace, change position to -1 if a '2' i present
      if value_positions.include?(0) && value_positions.include?(Card::VALUES.size-1)
        value_positions[value_positions.index(Card::VALUES.size-1)] = -1
      end
    
      return false if (value_positions.max - value_positions.min != 4)
      true
      HighCards.is?(cards)
    end
  end

  class ThreeOfAKind < Hand
    def self.is?(cards)
      Hand.kind?(cards, [1,1,3])
    end
  end

  class TwoPair < Hand
    def self.is?(cards)
      Hand.kind?(cards, [1,2,2])
    end
  end

  class OnePair < Hand
    def self.is?(cards)
      Hand.kind?(cards, [1,1,1,2])
    end
  end

  class HighCards < Hand
    def self.is?(cards)
      Hand.kind?(cards, [1,1,1,1,1])
    end
  end
end