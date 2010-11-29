require File.expand_path("../test_helper", File.dirname(__FILE__))

class TableTest < ActiveSupport::TestCase
  def setup
    @table = Table.new
  end

  # table setup
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
  
  # dealing tests
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

  test "dealing the flop should take a burn card and 3 cards off the deck" do
    @table.flop
    assert_equal 48, @table.deck.size
  end

  test "dealing the turn should have 4 cards on the table" do
    @table.flop
    @table.turn
    assert_equal 4, @table.cards.size
  end

  test "dealing the turn should take two burn cards and 4 cards off the deck" do
    @table.flop
    @table.turn
    assert_equal 46, @table.deck.size
  end

  test "dealing the river should have 5 cards on the table" do
    @table.flop
    @table.turn
    @table.river
    assert_equal 5, @table.cards.size
  end

  test "dealing the river should take 3 burn cards and 5 cards off the deck" do
    @table.flop
    @table.turn
    @table.river
    assert_equal 44, @table.deck.size
  end

  # full gameplay tests
  # [p1,p2,p3,p1,p2,p3,b1,f1,f2,f3,b2,t,b3,r]

  test "rigging the deck should deal cards to expected players" do
    rigged_cards = [
      5.H, 9.S, J.D, 
      6.H, 10.S, J.S, 2.H, 
      8.C, 7.S, 3.S, 3.H, 
      9.D, 4.S, 
      J.C]
    rigged_deck = Deck.new(rigged_cards)
    table = Table.new(rigged_deck)

    john = Player.new("John")
    paul = Player.new("Paul")
    george = Player.new("George")
    john.sit_down table
    paul.sit_down table
    george.sit_down table

    # assert dealt cards
    table.deal
    assert_equal Hole.new([5.H, 6.H]), john.hole
    assert_equal Hole.new([9.S, 10.S]), paul.hole
    assert_equal Hole.new([J.D, J.S]), george.hole
    
    # assert flop cards
    table.flop
    assert_equal [8.C, 7.S, 3.S], table.cards
    
    # assert turn card
    table.turn
    assert_equal 9.D, table.cards.last

    # assert river card
    table.river
    assert_equal J.C, table.cards.last
    
    # assert winner
    winners = table.winners
    assert_equal paul, winners.first
    
    # assert hands
    assert john.hand.kind_of? Straight
    assert paul.hand.kind_of? Straight
    assert george.hand.kind_of? ThreeOfAKind
  end
  
end