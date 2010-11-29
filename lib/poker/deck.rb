require 'set'
module Poker
  class Deck
    attr_reader :cards
  
    def initialize(fixed = [])
      @cards = []
      Card::SUITS.each do |suit|
        Card::VALUES.each do |value|
          @cards << Card.new(value, suit)
        end
      end
      fixed.reverse_each do |card|
        @cards.insert(0, @cards.delete(card))
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