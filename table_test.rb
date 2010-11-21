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
    @table.add_player player
    @table.has_player? player
  end
  
  test "adding an 11th player to the table should fail" do
    assert_raise RuntimeError do
      11.times { @table.add_player Player.new("John") }
    end
  end
  
  test "dealing the players should give a hand to all players" do
    john = Player.new("John")
    paul = Player.new("Paul")
    @table.add_player john
    @table.add_player paul
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

end