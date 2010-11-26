# The seven cards, 5 of which make the actual hand
require 'set'
class Hand
  attr_reader :cards

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
    (hole.cards.to_a + cards).combination(5).collect { |cards| Hand.create(cards) }
  end

  def self.create(cards)
    cards.to_set
  end
  
  def to_s
    puts @cards.join(" ")
  end

  # hand terms:
  def self.straight_flush?(cards)
    Hand.straight?(cards) && Hand.flush?(cards)
  end

  def self.four_of_a_kind?(cards)
    Hand.kind_count(cards) == [4,1].to_set
  end

  def self.full_house?(cards)
    Hand.kind_count(cards) == [3,2].to_set
  end
  
  def self.flush?(cards)
    cards.collect(&:suit).uniq.size == 1
  end

  def self.straight?(cards)
    false
  end

  def self.three_of_a_kind?(cards)
    Hand.kind_count(cards) == [3,1,1].to_set
  end

  def self.two_pair?(cards)
    Hand.kind_count(cards) == [2,2,1].to_set
  end

  def self.one_pair?(cards)
    Hand.kind_count(cards) == [2,1,1,1].to_set
  end

  def self.high_cards?(cards)
    Hand.kind_count(cards) == [1,1,1,1,1].to_set
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
end
class FourOfAKind < Hand
  # kind_count: 4,1
end
class FullHouse < Hand
  # kind_count: 3,2
end
class Flush < Hand
  # suit_count: 5
end
class Straight < Hand
end
class ThreeOfAKind < Hand
  # kind_count: 3,1,1
end
class TwoPair < Hand
  # kind_count: 2,2,1
end
class OnePair < Hand
  # kind_count: 2,1,1,1
end
class HighCards < Hand
  # kind_count: 1,1,1,1,1
end
