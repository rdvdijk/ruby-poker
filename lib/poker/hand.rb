# The seven cards, 5 of which make the actual hand
require 'set'

module Poker
  class Hand
    include Comparable
    attr_reader :cards
  
    ORDER = [:HighCards, :OnePair, :TwoPair, :ThreeOfAKind, :Straight, :Flush, :FullHouse, :FourOfAKind, :StraightFlush]

    def initialize(cards)
     @cards = cards.to_set
     @rank_count = Hand.rank_count(cards)
    end

    def <=>(other)
      ORDER.index(self.to_sym) <=> ORDER.index(other.to_sym)
    end
  
    def self.determine_hand(cards, hole)
      hands = (hole.cards.to_a + cards).combination(5).collect { |cards| Hand.create(cards) }
      hands.sort.max
    end

    def self.create(cards)
      ORDER.reverse_each do |hand|
        if const_get(hand).is?(cards)
          return const_get(hand).new(cards)
        end
      end
    end
    
    def compare_kickers(cards, compare_cards)
      cards.each_with_index do |card, i|
        compare = (compare_cards[i].rank_compare card)
        return compare if compare != 0
      end
      0
    end

    def to_sym
      class_name = self.class.to_s.split("::").last
      class_name.to_sym
    end
  
    def to_s
      @cards.inspect
    end
    
    def inspect
      self.class.to_s + ":" + to_s
    end
  
    private
  
    def self.rank_count(cards)
      rank_count = cards.inject(Hash.new(0)) do |hash,card| 
        hash[card.rank] += 1
        hash
      end
    end    
  end
end
