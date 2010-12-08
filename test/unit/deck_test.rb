# coding: UTF-8
require File.expand_path("../test_helper", File.dirname(__FILE__))

class CardTest < ActiveSupport::TestCase
  include Poker

  def setup
    @deck = Deck.new
  end
  
  test "a deck should not be empty" do
    assert !@deck.empty?
  end

  test "a deck should contain cards" do
    assert_not_nil @deck.cards
  end

  test "a deck should contain 52 cards" do
    assert_equal 52, @deck.size
  end

  # normal usage
  test "taking a card from the deck should give a card" do
    assert_not_nil @deck.take_card
  end

  test "taking a card from the deck should result in 51 cards in the deck" do
    card = @deck.take_card
    assert_equal 51, @deck.size
  end
  
  test "taking 52 cards of the deck should result in an empty deck" do
    52.times { @deck.take_card }
    assert @deck.empty?
  end

  test "taking one card of the deck should not leave it empty" do
    @deck.take_card
    assert !@deck.empty?
  end

  # random card usage
  test "picking a random card from the deck should give a card" do
    assert_not_nil @deck.random_card
  end

  test "picking a random card from the deck should result in 51 cards in the deck" do
    card = @deck.random_card
    assert_equal 51, @deck.size
  end
  
  test "picking 52 random cards of the deck should result in an empty deck" do
    52.times { @deck.random_card }
    assert @deck.empty?
  end

  test "picking one random card of the deck should not leave it empty" do
    @deck.random_card
    assert !@deck.empty?
  end
  
  # card ordering
  test "taking a card of a fresh deck should return the 2 of hearts" do
    assert_equal 2.♡, @deck.take_card
  end
  
  test "shuffling a deck should result in a different first card" do
    srand(23) # note: 24 shuffles 2.♡ on top
    @deck.shuffle
    assert_not_equal 2.♡, @deck.take_card
  end
    
  #test "printing a deck should print" do
  #  @deck.shuffle
  #  puts @deck
  #end

end