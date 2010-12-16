require "state_machine"

module Poker
  class Table
    attr_reader :deck
    attr_reader :pots
    attr_reader :board
    attr_reader :small_blind_amount, :big_blind_amount
    
    MAXIMUM_PLAYERS = 10
  
    def initialize
      @players = Array.new(MAXIMUM_PLAYERS, nil)
      @board = Board.new(self)
      @small_blind_amount = 5
      @big_blind_amount = 10
      full_reset
      super() # intialize state_machine
    end
    
    def players
      @players.compact
    end
  
    def empty?
      players.empty?
    end

    def has_players?
      players.size >= 2
    end

    # Add a player to the first empty spot on the table.
    def add_player(player)
      raise "A table can hold a maximum of 10 players." if players.size >= MAXIMUM_PLAYERS
      @players[position(nil)] = player unless @players.include? player
    end
    
    # Remove a player from the table, and leave an empty spot where she was
    # sitting.
    def remove_player(player)
      @players[position(player)] = nil
    end
  
    def has_player?(player)
      @players.include? player
    end
    
    def [](index)
      @players[index]
    end
    
    def position(player)
      @players.index(player)
    end
    
    state_machine :state, :initial => :start do      
      # the events between states:
      event :deal do
        transition :start => :pre_flop, :if => :has_players?
      end
      event :deal_flop do
        transition :pre_flop => :flop
      end
      event :deal_turn do
        transition :flop => :turn
      end
      event :deal_river do
        transition :turn => :river
      end
      event :reset do
        transition all => :start
      end
      
      # actions for events
      before_transition :start => :pre_flop do |table|
        table.update_buttons
        table.collect_blinds
        table.deal_players
      end
      before_transition :pre_flop => :flop do |table|
        table.board.deal_flop
      end
      before_transition :flop => :turn do |table|
        table.board.deal_turn
      end
      before_transition :turn => :river do |table|
        table.board.deal_river
      end
      before_transition any => :start do |table|
        table.full_reset
      end
    end
    
    def deal_players
      2.times {
        players.each { |player| player.give_card @deck.take_card }
      }
    end
        
    def full_reset
      @deck = Deck.new
      @deck.shuffle
      @board.reset
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
    
    def update_buttons
      dealer ? slide_dealer : initialize_dealer      
      update_blinds
    end
    
    def dealer
      @players[@dealer_position] unless !@dealer_position
    end
    
    def small_blind
      @players[@small_blind_position] unless !@small_blind_position
    end

    def big_blind
      @players[@big_blind_position] unless !@big_blind_position
    end
    
    def collect_blinds
      small_blind.collect_blind small_blind_amount
      big_blind.collect_blind big_blind_amount
    end
    
    def to_s
      "Cards on table: #{board}"
    end
  
    private
    
    def initialize_dealer
      return unless players.size >= 2
      first_player_index = @players.find_index { |player| !player.nil? }
      @dealer_position = first_player_index
    end
    
    # move dealer button to next player relative to dealer
    def slide_dealer
      @dealer_position = @players.index(next_player(dealer))
    end
    
    # Determine blinds positions based on dealer position.
    # Exception: with 2 players, the dealer is the small blind.
    def update_blinds
      if players.size == 2
        small_blind_player = dealer
      else
        small_blind_player = next_player(dealer)
      end
      big_blind_player = next_player(small_blind_player)
      
      @small_blind_position = @players.index(small_blind_player)
      @big_blind_position = @players.index(big_blind_player)
    end
    
    def next_player(player)
      player_index = @players.index(player)
      ordered_players = @players[player_index..-1] + @players[0,player_index]
      ordered_players.compact.find { |next_player| next_player != player}
    end
  end
end