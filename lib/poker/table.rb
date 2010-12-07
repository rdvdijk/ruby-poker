module Poker
  class Table
    attr_reader :deck
    attr_reader :pots
    attr_reader :cards
    attr_reader :dealer
    
    MAXIMUM_PLAYERS = 10
  
    def initialize(deck = Deck.new)
      @players = Array.new(MAXIMUM_PLAYERS, nil)
      @deck = deck
      @cards = []
    end
    
    def players
      @players.compact
    end
  
    def empty?
      players.empty?
    end
  
    def add_player(player)
      raise "A table can hold a maximum of 10 players." if players.size >= MAXIMUM_PLAYERS
      # TODO find first empty spot! (test)
      empty_spot = @players.index(nil)
      @players[empty_spot] = player unless @players.include? player
    end
    
    def [](index)
      @players[index]
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
        players.each { |player| player.give_card @deck.take_card }
      }
    end

    # TODO: implement state machine?
    def dealt?
      players.select(&:playing?).any?
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
    
    def state
      return :river if river?
      return :turn if turn?
      return :flop if flop?
      return :dealt if dealt?
      return :start if @cards.empty?
    end
    
    def reset
      @cards = []
      @deck = Deck.new
      players.each do |player|
        player.reset
      end
    end

    # Among the players that haven't folded, find those with the highest hand.
    def winners
      sorted = players.select(&:playing?).sort_by(&:hand)
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