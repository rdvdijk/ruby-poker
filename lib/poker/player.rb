module Poker
  class Player
    attr_reader :name
    attr_reader :hole
  
    def initialize(name)
      @name = name
      @hole = Hole.new
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
  
    def hand
      @hand ||= Hand.determine_hand(@table.cards, @hole)
    end
    
    def reset
      @hand = nil
      @hole = Hole.new
    end
  
    def to_s
      "#{@name} (#{@hole}) #{@hand}"
    end
    
    def inspect
      to_s
    end
  end
end