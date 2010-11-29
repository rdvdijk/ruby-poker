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
    assert_equal 3, @table.cards.size
  end

  test "dealing the turn should have 4 cards on the table" do
    @table.flop
    @table.turn
    assert_equal 4, @table.cards.size
  end

  test "dealing the river should have 5 cards on the table" do
    @table.flop
    @table.turn
    @table.river
    assert_equal 5, @table.cards.size
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

    pending
    return

    add_players(8)
    
    #[0,1,2,3,7,8,73,491,512].each do |seed|
    (0..1000).each do |seed|
      srand(seed)
      play_round_no_folds
      winners = @table.winners

      if winners.size>1
        puts "seed: #{seed} .. table: #{@table.cards.inspect}"
        winners.each do |player|
          puts player
        end
        puts
      end
      
      @table.reset
    end
    
  end
  
  private
  
  def add_players(size)
    (1..size).each do |id|
      player = Player.new("Player##{id}")
      player.sit_down @table
    end
  end
  
  def play_round_no_folds
    @table.deal
    @table.flop
    @table.turn
    @table.river
  end

end