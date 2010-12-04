module Poker
  class Table
    attr_reader :players
    attr_reader :deck
    attr_reader :pots
    attr_reader :cards
    attr_reader :dealer
  
    def initialize(deck = Deck.new)
      @players = []
      @deck = deck
      @cards = []
    end
  
    def empty?
      @players.empty?
    end
  
    def add_player(player)
      raise "A table can hold a maximum of 10 players." if @players.size >= 10
      @players << player unless @players.include? player
    end
    
    def remove_player(player)
      @players.delete player
    end
  
    def has_player?(player)
      @players.include? player
    end
  
    # TODO check if 'empty' table?
    def deal
      2.times {
        @players.each { |p| p.give_card @deck.take_card }
      }
    end
  
    def flop
      burn_card
      3.times { add_card }
    end
    
    def flop?
      @cards && @cards.size == 3
    end
    
    def flopped?
      @cards && @cards.size >= 3
    end
  
    def turn
      raise "Cannot deal turn" unless flop?
      burn_card
      add_card
    end

    def turn?
      @cards && @cards.size == 4
    end
  
    def river
      raise "Cannot deal river" unless turn?
      burn_card
      add_card
    end
    
    def river?
      @cards.size == 5
    end
    
    def burn_card
      deck.take_card
    end
    
    def reset
      @cards = []
      @deck = Deck.new
      @players.each do |player|
        player.reset
      end
    end

    # Among the players that haven't folded, find those with the highest hand.
    def winners
      sorted = @players.select(&:playing?).sort_by(&:hand)
      best_hand = sorted.last.hand
      sorted.select { |player| (player.hand <=> best_hand) == 0 }      
    end
    
    def to_s
      "Cards on table: #{cards.inspect}"
    end
  
    private
  
    def add_card
      @cards << @deck.take_card
    end
  end
end