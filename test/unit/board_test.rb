require File.expand_path("../test_helper", File.dirname(__FILE__))

class BoardTest < ActiveSupport::TestCase

  def setup
    @table = Table.new
    @board = @table.board
  end
  
  test "a new board should be empty" do
    assert @board.empty?
  end

  test "dealing the flop should have 3 cards on the table" do
    @board.deal_flop
    assert_equal 3, @board.cards.size
  end

  test "dealing the flop should take a burn card and 3 cards off the deck" do
    @board.deal_flop
    assert_equal 48, @table.deck.size
  end

  test "dealing the turn should have 4 cards on the table" do
    @board.deal_flop
    @board.deal_turn
    assert_equal 4, @board.cards.size
  end

  test "dealing the turn should take two burn cards and 4 cards off the deck" do
    @board.deal_flop
    @board.deal_turn
    assert_equal 46, @table.deck.size
  end

  test "dealing the river should have 5 cards on the table" do
    @board.deal_flop
    @board.deal_turn
    @board.deal_river
    assert_equal 5, @board.cards.size
  end

  test "dealing the river should take 3 burn cards and 5 cards off the deck" do
    @board.deal_flop
    @board.deal_turn
    @board.deal_river
    assert_equal 44, @table.deck.size
  end

  test "resetting the board should leave an empty board" do
    @board.reset(Deck.new)
    assert @board.empty?
  end
end