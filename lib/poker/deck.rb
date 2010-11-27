module Poker
  class Deck
    attr_reader :cards
  
    def initialize
      @cards = []
      Card::SUITS.each do |suit|
        Card::VALUES.each do |value|
          @cards << Card.new(value, suit)
        end
      end
    end
  
    def random_card
      @cards.delete_at(rand(cards.size))
    end
  
    def empty?
      @cards.empty?
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