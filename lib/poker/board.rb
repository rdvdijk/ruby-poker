module Poker
  class Board
    attr_reader :cards
    
    def initialize(table)
      @table = table
      full_reset
      super() # intialize state_machine
    end
    
    state_machine :state, :initial => :empty do
      # the events between states:
      event :deal_flop do
        transition :empty => :flop
      end
      event :deal_turn do
        transition :flop => :turn
      end
      event :deal_river do
        transition :turn => :river
      end
      event :reset do
        transition all => :empty
      end
      
      # actions for events
      before_transition :empty => :flop do |board|
        board.deal_flop
      end
      before_transition :flop => :turn do |board|
        board.deal_turn
      end
      before_transition :turn => :river do |board|
        board.deal_river
      end
      before_transition any => :empty do |board|
        board.full_reset
      end
    end
    
    def deck
      @table.deck
    end
    
    def full_reset
      @cards = []
    end
    
    def add_card
      @cards << deck.take_card
    end
    
    def burn_card
      deck.take_card
    end
    
    def deal_flop
      burn_card
      3.times { add_card }
    end
    
    def deal_turn
      burn_card
      add_card
    end
    
    def deal_river
      burn_card
      add_card
    end
    
    def to_s
      @cards.inspect
    end
  end
end
