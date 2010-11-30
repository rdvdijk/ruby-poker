# coding: UTF-8
require File.expand_path("../test_helper", File.dirname(__FILE__))

# This integration test verifies that when the cards are dealt, and no player
# folds, the player with the best hand wins.
#
# The deck of cards is 'rigged' to get testable results.
#
# As an example for three players, the order of cards in a deck are:
#   [p1, p2, p3, p1, p2, p3, b1, f, f, f, b2, t, b3, r]
# Where:
#  pX = card for a player (p2, p3, etc)
#  bX = burn
#  f  = flop
#  t  = turn
##  r  = river
class DealingTest < ActiveSupport::TestCase

  test "rigging the deck should deal cards to expected players straight/straight/three-of-a-kind" do
    rigged_cards = [
      5.H, 9.S, J.D, 
      6.H, T.S, J.S, 2.H, 
      8.C, 7.S, 3.S, 3.H, 
      9.D, 4.S, 
      J.C
    ]
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
    assert_equal Hole.new([9.S, T.S]), paul.hole
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