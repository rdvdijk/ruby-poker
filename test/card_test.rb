# coding: UTF-8
require 'test_helper'

class CardTest < ActiveSupport::TestCase
  include Poker

  test "creating a card with a value and suit should work" do
    card = Card.new(:A, :spades)
  end
  
  test "creating a plain card should fail" do
    assert_raise ArgumentError do
      card = Card.new
    end
  end
  
  test "creating a card with a wrong value should fail" do
    assert_raise ArgumentError do
      card = Card.new(:X, :spades)
    end
  end

  test "creating a card with a wrong suit should fail" do
    assert_raise ArgumentError do
      card = Card.new(:A, :squirrels)
    end
  end

  test "printing a card should print proper value and suit" do
    card = Card.new(:A, :spades)
    assert_equal "A♠", card.to_s
  end
  
  test "creating cards using shorthands should work" do
    assert_equal Card.new(:A, :spades), A.♠
    assert_equal Card.new(:A, :spades), A.spades
    assert_equal Card.new(:A, :spades), A.S
    assert_equal Card.new(:A, :spades), A.of("spades")
    assert_equal Card.new(:A, :spades), A.of(:spades)

    assert_equal Card.new(:"5", :hearts), 5.♡
    assert_equal Card.new(:"5", :hearts), 5.hearts
    assert_equal Card.new(:"5", :hearts), 5.H
    assert_equal Card.new(:"5", :hearts), 5.of("hearts")
    assert_equal Card.new(:"5", :hearts), 5.of(:hearts)
  end

end