module Poker
  class Board
    attr_reader :cards
    
    def initialize(deck)
      @cards = []
      @deck = deck
    end
    
    def reset(deck)
      @cards = []
      @deck = deck
    end
    
    def add_card
      @cards << @deck.take_card
    end
    
    def burn_card
      @deck.take_card
    end
    
    def empty?
      @cards.size == 0
    end
    
    def flop
      burn_card
      3.times { add_card }
    end
    
    def turn
      raise "Cannot deal turn" unless flop?
      burn_card
      add_card
    end
    
    def river
      raise "Cannot deal river" unless turn?
      burn_card
      add_card
    end
    
    def flop?
      @cards && @cards.size == 3
    end
    
    def flopped?
      @cards && @cards.size >= 3
    end
  
    def turn?
      @cards && @cards.size == 4
    end
  
    def river?
      @cards.size == 5
    end    
  end
end
