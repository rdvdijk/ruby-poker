require File.expand_path("../test_helper", File.dirname(__FILE__))

class HoleTest < ActiveSupport::TestCase
  def setup
    @deck = Deck.new
  end

  test "a new hole should not contain cards" do
    hole = Hole.new
    assert hole.cards.empty?
  end

  test "a new hole should be empty" do
    hole = Hole.new
    assert hole.empty?
  end

  test "a new hole should not be dealt" do
    hole = Hole.new
    assert !hole.dealt?
  end

  test "adding a card to a hole should add the card to the hole" do
    card = @deck.random_card
    hole = Hole.new
    hole << card
    assert hole.include? card
  end

  test "adding two cards to a hole should add those cards to the hole" do
    card = @deck.random_card
    card2 = @deck.random_card
    hole = Hole.new
    hole << card
    hole << card2
    assert hole.include? card
    assert hole.include? card2
  end

  test "adding two cards to a hole should result in a dealt hole" do
    card = @deck.random_card
    card2 = @deck.random_card
    hole = Hole.new
    hole << card
    hole << card2
    assert hole.dealt?
  end
  
  test "folding a hole should result in an empty hole" do
    hole = Hole.new
    hole << @deck.random_card
    hole << @deck.random_card
    hole.fold
    assert hole.empty?
  end
end