require 'test_helper'

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
  
  test "initializing player should result in a player with an empty hand" do
    player = Player.new("John")
    assert player.hand.empty?
  end
  
  test "initializing player should result in a player without a dealt hand" do
    player = Player.new("John")
    assert !player.dealt?
  end
  
  test "giving a card to a player should add that card to the hand" do
    player = Player.new("John")
    card = Deck.new.random_card
    player.give_card card
    assert player.hand.include? card
  end

  test "dealing to a player should give a dealt player" do
    player = Player.new("John")
    deck = Deck.new
    2.times { player.give_card deck.random_card }
    assert player.dealt?
  end
  
  test "folding the player should fold the players hand" do
    player = Player.new("John")
    deck = Deck.new
    2.times { player.give_card deck.random_card }
    player.fold
    assert player.folded?
  end

end