# A pot is a betted amount that a number of players can win, this amount is
# called the "pot size".
# When a player "goes all-in" this can create one or multiple side-pots,
# which the all-in-player is cannot win anymore.
module Poker
  class Pot
    attr_reader :size
    attr_reader :players
    
    def initialize
      @size = 0
      @players = []
    end
    
    def add_player(player)
      players << player
    end
    
    def remove_player(player)
      players.delete player
    end
    
    def add(amount)
      @size += amount
    end
    
    def pay_out(*players)
      players.each do |player|
        player.pay(@size)
      end
    end
  end
end