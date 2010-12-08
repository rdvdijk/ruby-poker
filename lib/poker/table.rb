module Poker
  class Table
    attr_reader :deck
    attr_reader :pots
    attr_reader :board
    attr_reader :dealer
    
    MAXIMUM_PLAYERS = 10
  
    def initialize(deck = Deck.new)
      @players = Array.new(MAXIMUM_PLAYERS, nil)
      @deck = deck
      @board = Board.new(@deck)
      @dealer_position = nil
    end
    
    def players
      @players.compact
    end
  
    def empty?
      players.empty?
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
  
    # TODO check if 'empty' table?
    def deal
      2.times {
        players.each { |player| player.give_card @deck.take_card }
      }
    end

    def dealt?
      players.select(&:playing?).any?
    end
    
    def flop
      @board.flop
    end
    
    def turn
      @board.turn
    end
    
    def river
      @board.river
    end
    
    # TODO: implement state machine
    def state
      return :river if @board.river?
      return :turn if @board.turn?
      return :flop if @board.flop?
      return :dealt if dealt?
      return :start if @board.cards.empty?
    end
    
    def reset
      @deck = Deck.new
      @board.reset(deck)
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
      if @dealer_position
        slide_dealer
        update_blinds
      else
        initialize_dealer
        update_blinds
      end
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
    
    def to_s
      "Cards on table: #{cards.inspect}"
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
    
    # determine blinds positions based on dealer
    # exception: with 2 players, the dealer is the small blind
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