# coding: UTF-8
require File.expand_path("../test_helper", File.dirname(__FILE__))

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
    assert_equal Card.new(:K, :spades), K.spades
    assert_equal Card.new(:Q, :spades), Q.S
    assert_equal Card.new(:J, :spades), J.of("spades")
    assert_equal Card.new(:A, :spades), A.of(:spades)

    assert_equal Card.new(:"6", :hearts), 6.♡
    assert_equal Card.new(:"5", :hearts), 5.hearts
    assert_equal Card.new(:"4", :hearts), 4.H
    assert_equal Card.new(:"3", :hearts), 3.of("hearts")
    assert_equal Card.new(:"2", :hearts), 2.of(:hearts)
  end
  
  test "using a T as a shorthand for 10 should work" do
    assert_equal Card.new(:"10", :spades), T.♠
  end

end