module Poker
  class StraightFlush < Flush
    attr_reader :sorted_cards
    
    def self.is?(cards)
      Flush.is?(cards) && Straight.is?(cards)
    end
    
    def to_s
      "StraightFlush: #{@sorted_cards.inspect}"
    end
  end
end