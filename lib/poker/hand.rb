# The seven cards, 5 of which make the actual hand
require 'set'
class Hand
  attr_reader :cards
  
  ORDER = [:StraightFlush, :FourOfAKind, :FullHouse, :Flush, :Straight, :ThreeOfAKind, :TwoPair, :OnePair, :HighCards]

  def initialize(cards)
    @cards = cards.to_set
  end

  def <=>(other)
    # TODO: poker hand logic goes here
    
    # one way:
    #   http://nsayer.blogspot.com/2007/07/algorithm-for-evaluating-poker-hands.html
    # or a big table of all hands:
    #   http://www.suffecool.net/poker/evaluator.html
    # round-up:
    #   http://www.codingthewheel.com/archives/poker-hand-evaluator-roundup
    
    # dummy:

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
    puts @cards.join(" ")
  end
  
  private
  
  def self.kind_count(cards)
    kind_count = cards.inject(Hash.new(0)) do |hash,card| 
      hash[card.value] += 1
      hash
    end
    Set.new kind_count.values
  end
  
end

class StraightFlush < Hand
  def self.is?(cards)
    Straight.is?(cards) && Flush.is?(cards)
  end
end

class FourOfAKind < Hand
  def self.is?(cards)
    Hand.kind_count(cards) == [4,1].to_set
  end
end

class FullHouse < Hand
  def self.is?(cards)
    Hand.kind_count(cards) == [3,2].to_set
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
    # check for consecutive cards
    # consecutive = value_positions.inject(nil) do |consecutive,position|
    #   consecutive && 
    #   position
    # end
  end
end

class ThreeOfAKind < Hand
  def self.is?(cards)
    Hand.kind_count(cards) == [3,1,1].to_set
  end
end

class TwoPair < Hand
  def self.is?(cards)
    Hand.kind_count(cards) == [2,2,1].to_set
  end
end

class OnePair < Hand
  def self.is?(cards)
    Hand.kind_count(cards) == [2,1,1,1].to_set
  end
end

class HighCards < Hand
  def self.is?(cards)
    Hand.kind_count(cards) == [1,1,1,1,1].to_set
  end
end
