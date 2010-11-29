# http://en.wikipedia.org/wiki/Glossary_of_poker_terms#hole
#
# The two cards dealt to a player
require 'set'
module Poker
  class Hole
    attr_reader :cards
  
    def initialize(cards = nil)
      @cards = Set.new cards
    end
    
    def <<(card)
      raise "A hole has 2 cards" if @cards.size >= 2
      @cards << card
    end
  
    def include?(card)
      @cards.include? card
    end
  
    def empty?
      @cards.empty?
    end
  
    def dealt?
      @cards.size == 2
    end
  
    def fold
      @cards.clear
    end
  
    def to_s
      "#{@cards.to_a.join(' ')}"
    end
    
    def ==(other)
      @cards == other.cards
    end
  end
end