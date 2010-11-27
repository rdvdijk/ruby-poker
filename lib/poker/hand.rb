# The seven cards, 5 of which make the actual hand
require 'set'

module Poker
  class Hand
    include Comparable
    attr_reader :cards
  
    ORDER = [:HighCards, :OnePair, :TwoPair, :ThreeOfAKind, :Straight, :Flush, :FullHouse, :FourOfAKind, :StraightFlush]

    def initialize(cards)
     @cards = cards.to_set
     @kind_count = Hand.kind_count(cards)
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
        compare = (compare_cards[i].value_compare card)
        return compare if compare != 0
      end
      0
    end

    # get pair cards
    def get_pairs
      pair_info = Hash[@kind_count.select {|value, count| count==2 }]
      pair_cards = cards_by_value(pair_info.keys)
    end
    
    def same_value(same)
      @kind_count.select {|value, count| count==same }[0][0]
    end

    # select cards in hand of given values
    def cards_by_value(values)
      @cards.select { |card| values.include?(card.value) }
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
  
    def self.kind_count(cards)
      kind_count = cards.inject(Hash.new(0)) do |hash,card| 
        hash[card.value] += 1
        hash
      end
    end
    
    # http://www.ruby-forum.com/topic/89101#171173
    def self.kind?(cards, wanted)
      found = Hand.kind_count(cards).values
      found.sort_by{|n| n.hash} == wanted.sort_by {|n|n.hash}
    end
  end
end
