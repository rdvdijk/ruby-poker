# coding: UTF-8
require 'test_helper'

class CardTest < ActiveSupport::TestCase

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

end