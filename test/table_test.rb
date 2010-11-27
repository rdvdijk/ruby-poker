require 'test_helper'

class TableTest < ActiveSupport::TestCase
  def setup
    @table = Table.new
  end

  test "a new table should not have any players" do
    assert @table.empty?
  end
  
  test "adding a player to a table should add the player" do
    player = Player.new("John")
    player.sit_down @table
    @table.has_player? player
  end
  
  test "adding an 11th player to the table should fail" do
    assert_raise RuntimeError do
      11.times { Player.new("John").sit_down @table }
    end
  end
  
  test "dealing the players should give a hole to all players" do
    john = Player.new("John")
    paul = Player.new("Paul")
    john.sit_down @table
    paul.sit_down @table
    @table.deal
    assert john.dealt?
    assert paul.dealt?
  end
  
  test "dealing the flop should have 3 cards on the table" do
    @table.flop
    assert 3, @table.cards.size
  end

  test "dealing the turn should have 4 cards on the table" do
    @table.flop
    @table.turn
    assert 4, @table.cards.size
  end

  test "dealing the river should have 5 cards on the table" do
    @table.flop
    @table.turn
    @table.river
    assert 5, @table.cards.size
  end

  test "determining the winner finds the highest winner(s)" do
    # fixate randomness
    #srand(0) # one pair
    #srand(1) # straight
    #srand(2) # flush
    #srand(3) # three of a kind
    #srand(7) # full house
    #srand(8) # two pairs
    #srand(73) # four of a kind
    #srand(491) # high cards
    #srand(512) # straight flush

    add_8_players
    
    [0,1,2,3,7,8,73,491,512].each do |seed|
      srand(seed)

      @table.deal
      @table.flop
      @table.turn
      @table.river

      winner = @table.winner
    
      #puts winner
      #puts @table

      winner.each do |player|
        puts player
      end
      
      @table.reset
    end
    
  end
  
  private
  
  def add_8_players
    (1..8).each do |id|
      player = Player.new("Player##{id}")
      player.sit_down @table
    end
  end 

end