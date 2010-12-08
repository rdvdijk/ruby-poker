require 'set'
module Poker
  class Deck
    attr_reader :cards
  
    def initialize
      @cards = []
      Card::SUITS.each do |suit|
        Card::RANKS.each do |rank|
          @cards << Card.new(rank, suit)
        end
      end
    end
    
    def take_card
      @cards.delete_at(0)
    end
    
    def shuffle
      @cards.shuffle!
    end
  
    def random_card
      @cards.delete_at(rand(cards.size))
    end
  
    def empty?
      @cards.empty?
    end
    
    def size
      @cards.size
    end
  
    def to_s
      result = ""
      @cards.each do |card|
         result << card.to_s + "\n"
      end
      result
    end
  end
end