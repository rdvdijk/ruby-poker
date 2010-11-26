require 'test_helper'

class HandTest < ActiveSupport::TestCase

  test "a 'high cards' hand should return HighCards hand" do
    hole = Hole.new
    hole << Card.new(:"2", :clubs)
    hole << Card.new(:"3", :hearts)
    
    cards = high_cards
    
    combinations = Hand.determine_hand(cards, hole)
    
    combinations.each do |hand|
      #p hand
    end
  end

  # straight flush -----------------------------------------------------------
  test "a straight flush hand should be straight flush" do
    assert StraightFlush.is?(straight_flush)
  end

  test "a non straight flush hand should not return straight flush" do
    assert !StraightFlush.is?(high_cards)
  end

  # four of a kind -----------------------------------------------------------
  test "a four of a kind hand should return four of a kind" do
    assert FourOfAKind.is?(four_of_a_kind)
  end

  test "a non four of a kind hand should not return four of a kind" do
    assert !FourOfAKind.is?(high_cards)
  end

  # full house ---------------------------------------------------------------
  test "a full house hand should return full house" do
    assert FullHouse.is?(full_house)
  end

  test "a non full house hand should not return full house" do
    assert !FullHouse.is?(high_cards)
  end

  # flush --------------------------------------------------------------------
  test "a flush hand should return flush" do
    assert Flush.is?(flush)
  end

  test "a non flush hand should not return flush" do
    assert !Flush.is?(high_cards)
  end

  # straight -----------------------------------------------------------------
  test "a straight hand should return straight" do
    assert Straight.is?(straight)
  end

  test "a non straight hand should not return straight" do
    assert !Straight.is?(high_cards)
  end

  test "a five-high straight hand should return straight" do
    assert Straight.is?(straight_five_high)
  end

  test "a non consecutive cards hand should not return straight" do
    assert !Straight.is?(non_consecutive_hand)
  end

  # three of a kind ----------------------------------------------------------
  test "a three of a kind hand should return three of a kind" do
    assert ThreeOfAKind.is?(three_of_a_kind)
  end

  test "a non three of a kind hand should not return two pair" do
    assert !ThreeOfAKind.is?(high_cards)
  end

  test "a full house hand should not return three of a kind" do
    assert !ThreeOfAKind.is?(full_house)
  end

  test "a four of a kind hand should not return three of a kind" do
    assert !ThreeOfAKind.is?(four_of_a_kind)
  end

  # two pair -----------------------------------------------------------------
  test "a two pair hand should return two pair" do
    assert TwoPair.is?(two_pair)
  end

  test "a non two pair hand should not return two pair" do
    assert !TwoPair.is?(high_cards)
  end

  test "a three of a kind hand should not return two pair" do
    assert !TwoPair.is?(three_of_a_kind)
  end

  # one pair -----------------------------------------------------------------
  test "a one pair hand should return one pair" do
    assert OnePair.is?(one_pair)
  end

  test "a non one pair hand should not return one pair" do
    assert !OnePair.is?(high_cards)
  end

  private
  
  def straight_flush
    [
      Card.new(:"5", :spades),
      Card.new(:"6", :spades),
      Card.new(:"7", :spades),
      Card.new(:"8", :spades),
      Card.new(:"9", :spades)
    ]
  end
  
  def four_of_a_kind
    [
      Card.new(:"2", :spades),
      Card.new(:Q, :hearts),
      Card.new(:Q, :spades),
      Card.new(:Q, :clubs),
      Card.new(:Q, :diamonds)
    ]
  end

  def full_house
    [
      Card.new(:"2", :spades),
      Card.new(:"2", :hearts),
      Card.new(:Q, :spades),
      Card.new(:Q, :clubs),
      Card.new(:Q, :diamonds)
    ]
  end
  
  def flush
    [
      Card.new(:"5", :spades),
      Card.new(:"6", :spades),
      Card.new(:"8", :spades),
      Card.new(:"9", :spades),
      Card.new(:J, :spades)
    ]
  end

  def straight
    [
      Card.new(:"5", :spades),
      Card.new(:"6", :hearts),
      Card.new(:"7", :spades),
      Card.new(:"8", :clubs),
      Card.new(:"9", :diamonds)
    ]
  end

  def straight_five_high
    [
      Card.new(:"A", :spades),
      Card.new(:"2", :hearts),
      Card.new(:"3", :spades),
      Card.new(:"4", :clubs),
      Card.new(:"5", :diamonds)
    ]
  end
  
  def non_consecutive_hand
    [
      Card.new(:"A", :spades),
      Card.new(:"2", :hearts),
      Card.new(:"4", :spades),
      Card.new(:"4", :clubs),
      Card.new(:"5", :diamonds)
    ]
  end

  def three_of_a_kind
    [
      Card.new(:"5", :spades),
      Card.new(:"6", :hearts),
      Card.new(:J, :spades),
      Card.new(:J, :clubs),
      Card.new(:J, :diamonds)
    ]
  end

  def two_pair
    [
      Card.new(:"3", :spades),
      Card.new(:"7", :hearts),
      Card.new(:"7", :spades),
      Card.new(:K, :clubs),
      Card.new(:K, :diamonds)
    ]
  end

  def one_pair
    [
      Card.new(:"3", :spades),
      Card.new(:"7", :hearts),
      Card.new(:"8", :spades),
      Card.new(:A, :clubs),
      Card.new(:A, :diamonds)
    ]
  end

  def high_cards
    [
      Card.new(:"5", :spades),
      Card.new(:"6", :diamonds),
      Card.new(:"8", :hearts),
      Card.new(:"9", :clubs),
      Card.new(:J, :spades)
    ]
  end
end