module Poker
  class Player
    attr_reader :name
    attr_reader :hole
    attr_reader :stack
    attr_reader :bet
  
    def initialize(name, stack = 1000)
      @name = name
      @hole = Hole.new
      @stack = stack
      @bet = 0
    end
  
    def give_card(card)
      @hole << card
    end
  
    def fold
      @hole.fold
    end
  
    def dealt?
      @hole.dealt?
    end
  
    def folded?
      @hole.empty?
    end
  
    def playing?
      !folded?
    end
  
    def sit_down(table)
      @table = table
      @table.add_player self
    end
    
    def sitting_down?
      @table != nil
    end
    
    def stand_up
      @table.remove_player self
      @table = nil
    end
    
    def at_table?(table)
      @table.has_player? self
    end
  
    def hand
      @hand ||= Hand.determine_hand(@table.board.cards, @hole)
    end
    
    def reset
      @hand = nil
      @hole = Hole.new
    end
    
    def collect_blind(amount)
      place_bet(amount)
    end

    def place_bet(amount)
      @bet += amount
      @stack -= amount
    end
    
    # TODO test:
    def pay(amount)
      @stack += amount
    end
    
    def to_s
      "#{@name} (#{@hole}) #{@hand}"
    end
    
    def inspect
      to_s
    end
  end
end