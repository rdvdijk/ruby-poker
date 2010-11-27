require 'test_helper'

class CardTest < ActiveSupport::TestCase
  include Poker

  def setup
    @deck = Deck.new
  end

  test "a deck should contain cards" do
    assert_not_nil @deck.cards
  end

  test "a deck should contain 52 cards" do
    assert 52, @deck.cards.size
  end
  
  test "picking a random card from the deck should give a card" do
    assert_not_nil @deck.random_card
  end

  test "picking a random card from the deck should result in 51 cards in the deck" do
    card = @deck.random_card
    assert_equal 51, @deck.cards.size
  end
  
  test "picking 52 cards of the deck should result in an empty deck" do
    52.times { @deck.random_card }
    assert @deck.empty?
  end
  
  test "an original deck should not be empty" do
    assert !@deck.empty?
  end

  test "picking one random card of the deck should not leave it empty" do
    @deck.random_card
    assert !@deck.empty?
  end

  # test "printing a deck should print" do
  #   puts @deck
  # end

end