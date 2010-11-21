require 'test_helper'

class HandTest < ActiveSupport::TestCase

  test "a new hand should not contain cards" do
    hand = Hand.new
    assert hand.cards.empty?
  end

  test "a new hand should be empty" do
    hand = Hand.new
    assert hand.empty?
  end

  test "a new hand should not be dealt" do
    hand = Hand.new
    assert !hand.dealt?
  end
  
  test "adding a card to a hand should add the card to the hand" do
    card = Deck.new.random_card
    hand = Hand.new
    hand << card
    assert hand.include? card
  end

  test "adding two cards to a hand should add those cards to the hand" do
    card = Deck.new.random_card
    card2 = Deck.new.random_card
    hand = Hand.new
    hand << card
    hand << card2
    assert hand.include? card
    assert hand.include? card2
  end

  test "adding two cards to a hand should result in a dealt hand" do
    card = Deck.new.random_card
    card2 = Deck.new.random_card
    hand = Hand.new
    hand << card
    hand << card2
    assert hand.dealt?
  end
  
  test "folding a hand should result in an empty hand" do
    hand = Hand.new
    hand << Deck.new.random_card
    hand << Deck.new.random_card
    hand.fold
    assert hand.empty?
  end

end