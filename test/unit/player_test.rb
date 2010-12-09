require File.expand_path("../test_helper", File.dirname(__FILE__))

class PlayerTest < ActiveSupport::TestCase
  test "initializing player without a name should fail" do
    assert_raise ArgumentError do
      Player.new
    end
  end
  
  test "initializing player with a name should work" do
    player = Player.new("John")
    assert_not_nil player
  end

  test "initializing player should give a stack of 1000" do
    player = Player.new("John")
    assert_equal 1000, player.stack
  end

  test "initializing player with stack should give the player that stack" do
    player = Player.new("John", 2500)
    assert_equal 2500, player.stack
  end
  
  test "initializing player should result in a player with an empty hole" do
    player = Player.new("John")
    assert player.hole.empty?
  end
  
  test "initializing player should result in a player without a dealt hole" do
    player = Player.new("John")
    assert !player.dealt?
  end
  
  test "giving a card to a player should add that card to the hole" do
    player = Player.new("John")
    card = Deck.new.random_card
    player.give_card card
    assert player.hole.include? card
  end

  test "dealing to a player should give a dealt player" do
    player = Player.new("John")
    deck = Deck.new
    2.times { player.give_card deck.random_card }
    assert player.dealt?
  end
  
  test "folding the player should fold the players hole" do
    player = Player.new("John")
    deck = Deck.new
    2.times { player.give_card deck.random_card }
    player.fold
    assert player.folded?
  end
  
  test "resetting a player should leave her without a hole or a hand" do
    table = Table.new
    john = Player.new("John")
    paul = Player.new("Paul")
    john.sit_down table
    paul.sit_down table
    table.deal
    table.deal_flop
    john.reset
    assert john.hole.empty?
    assert_nil john.hand
  end
  
  test "collecting a blind should have the player betting that amount" do
    player = Player.new("John")
    player.collect_blind 5
    assert_equal 5, player.bet
  end
  
  test "betting should raise the player's bet" do
    player = Player.new("John")
    player.place_bet 10
    assert_equal 10, player.bet
  end
  
  test "betting should lower the player's stack" do
    player = Player.new("John", 1000)
    player.place_bet 10
    assert_equal 990, player.stack
  end

  test "a players bet and stack should add up to previous stack" do
    stack = 1000
    player = Player.new("John", stack)
    player.place_bet 10
    assert_equal stack, player.bet + player.stack
  end
end