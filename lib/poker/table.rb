module Poker
  class Table
    attr_reader :players
    attr_reader :deck
    attr_reader :pot
    attr_reader :cards
    attr_reader :dealer
  
    def initialize
      @players = []
      @deck = Deck.new
      @cards = []
    end
  
    def empty?
      @players.empty?
    end
  
    def add_player(player)
      raise "A table can hold a maximum of 10 players" if @players.size >= 10
      @players << player
    end
  
    def has_player?(player)
      @players.include? player
    end
  
    def deal
      2.times {
        @players.each { |p| p.give_card @deck.random_card }
      }
    end
  
    def flop
      3.times { add_card }
    end
  
    def turn
      raise "Cannot deal turn" unless @cards.size == 3
      add_card
    end
  
    def river
      raise "Cannot deal river" unless @cards.size == 4
      add_card
    end
  
    def winner
      active_players = @players.select(&:playing?)
      active_players.sort_by { |player| player.hand }
    end
  
    private
  
    def add_card
      @cards << @deck.random_card
    end
  end
end