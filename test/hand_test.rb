# coding: UTF-8
require 'test_helper'

class HandTest < ActiveSupport::TestCase
  test "a 'high cards' hand should return the best HighCards hand" do
    hole = Hole.new
    hole << 2.♠
    hole << 3.♡
    cards = [5.♠, 6.♢, 8.♡, 9.♣, J.♠]

    hand = Hand.determine_hand(cards, hole)
    expected = Set.new [5.♠, 6.♢, 8.♡, 9.♣, J.♠]
    
    assert_equal expected, hand.cards
  end
  
  # hand order tests (a few) -------------------------------------------------
  test "a straight flush should win from a flush" do
    assert Hand.create([5.♠, 6.♠, 7.♠, 8.♠, 9.♠]) > Hand.create([2.♠, 3.♠, 7.♠, 8.♠, 9.♠])
  end

  test "a straight should win from a three of a kind" do
    assert Hand.create([5.♠, 6.♡, 7.♠, 8.♣, 9.♢]) > Hand.create([5.♠, 6.♡, 9.♠, 9.♣, 9.♢])
  end

  test "a four of a kind should win from two pair" do
    assert Hand.create([6.♠, Q.♡, Q.♠, Q.♣, Q.♢]) > Hand.create([6.♠, 6.♡, 7.♠, Q.♣, Q.♢])
  end

  test "a three of a kind should win from two pair" do
    assert Hand.create([5.♠, 6.♡, J.♠, J.♣, J.♢]) > Hand.create([A.♠, 6.♡, 6.♠, J.♣, J.♢])
  end

  # straight flush -----------------------------------------------------------
  test "a straight flush hand should be straight flush" do
    assert StraightFlush.is?(straight_flush)
  end

  test "a non straight flush hand should not return straight flush" do
    assert !StraightFlush.is?(high_cards)
  end
  
  test "a better straight flush hand should win" do
    straight_flush1 = Hand.create(straight_flush)
    straight_flush2 = Hand.create(straight_flush_better)
    assert straight_flush1 < straight_flush2
  end

  # an equal straight flush isn't possible with 7 cards

  # four of a kind -----------------------------------------------------------
  test "a four of a kind hand should return four of a kind" do
    assert FourOfAKind.is?(four_of_a_kind)
  end

  test "a non four of a kind hand should not return four of a kind" do
    assert !FourOfAKind.is?(high_cards)
  end

  test "an equal four of a kind hand should draw" do
    four_of_a_kind1 = Hand.create(four_of_a_kind)
    four_of_a_kind2 = Hand.create(four_of_a_kind_equal)
    assert four_of_a_kind1 == four_of_a_kind2
  end

  test "a better four of a kind hand should win" do
    four_of_a_kind1 = Hand.create(four_of_a_kind)
    four_of_a_kind2 = Hand.create(four_of_a_kind_better)
    assert four_of_a_kind1 < four_of_a_kind2
  end

  test "an equal four of a kind hand with better kicker should win" do
    four_of_a_kind1 = Hand.create(four_of_a_kind)
    four_of_a_kind2 = Hand.create(four_of_a_kind_better_kicker)
    assert four_of_a_kind1 < four_of_a_kind2
  end

  # full house ---------------------------------------------------------------
  test "a full house hand should return full house" do
    assert FullHouse.is?(full_house)
  end

  test "a non full house hand should not return full house" do
    assert !FullHouse.is?(high_cards)
  end
  
  test "a better full house hand should win" do
    full_house1 = Hand.create(full_house)
    full_house2 = Hand.create(full_house_better)
    assert full_house1 < full_house2
  end

  test "an equal full house hand should draw" do
    full_house1 = Hand.create(full_house)
    full_house2 = Hand.create(full_house_equal)
    assert full_house1 == full_house2
  end

  # flush --------------------------------------------------------------------
  test "a flush hand should return flush" do
    assert Flush.is?(flush)
  end

  test "a non flush hand should not return flush" do
    assert !Flush.is?(high_cards)
  end
  
  test "a better flush hand should win" do
    flush1 = Hand.create(flush)
    flush2 = Hand.create(flush_better)
    assert flush1 < flush2
  end
  
  # note: 'equal' flushes aren't possible with 7 card

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
  
  test "a better straight hand should win" do
    straight1 = Hand.create(straight)
    straight2 = Hand.create(straight_better)
    assert straight1 < straight2
  end

  test "a five-high straight should lose from a higher straight" do
    straight1 = Hand.create(straight)
    straight2 = Hand.create(straight_five_high)
    assert straight1 > straight2
  end

  test "an ace-high straight should win from a 5-high straight" do
    straight1 = Hand.create(straight_ace_high)
    straight2 = Hand.create(straight_five_high)
    assert straight1 > straight2
  end

  # three of a kind ----------------------------------------------------------
  test "a three of a kind hand should return three of a kind" do
    assert ThreeOfAKind.is?(three_of_a_kind)
  end

  test "a non three of a kind hand should not return three of a kind" do
    assert !ThreeOfAKind.is?(high_cards)
  end

  test "a full house hand should not return three of a kind" do
    assert !ThreeOfAKind.is?(full_house)
  end

  test "a four of a kind hand should not return three of a kind" do
    assert !ThreeOfAKind.is?(four_of_a_kind)
  end

  test "equal three of a kind hands should draw" do
    three_of_a_kind1 = Hand.create(three_of_a_kind)
    three_of_a_kind2 = Hand.create(three_of_a_kind_equal)
    assert three_of_a_kind1 == three_of_a_kind2
  end
  
  test "a better three of a kind hand should win" do
    three_of_a_kind1 = Hand.create(three_of_a_kind)
    three_of_a_kind2 = Hand.create(three_of_a_kind_better)
    assert three_of_a_kind1 < three_of_a_kind2
  end

  test "an equal three of a kind hands with better kicker should win" do
    three_of_a_kind1 = Hand.create(three_of_a_kind)
    three_of_a_kind2 = Hand.create(three_of_a_kind_better_kicker)
    assert three_of_a_kind1 < three_of_a_kind2
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
  
  test "equal two pairs should draw" do
    two_pair1 = Hand.create(two_pair)
    two_pair2 = Hand.create(two_pair_equal)
    assert two_pair1 == two_pair2
  end

  test "a better pair should win" do
    two_pair1 = Hand.create(two_pair)
    two_pair2 = Hand.create(two_pair_better_high)
    assert two_pair1 < two_pair2
  end

  test "first same pair but better second pair should win" do
    two_pair1 = Hand.create(two_pair)
    two_pair2 = Hand.create(two_pair_better_low)
    assert two_pair1 < two_pair2
  end
  
  test "equal two pair with better kicker should win" do
    two_pair1 = Hand.create(two_pair)
    two_pair2 = Hand.create(two_pair_better_kicker)
    assert two_pair1 < two_pair2
  end

  # one pair -----------------------------------------------------------------
  test "a one pair hand should return one pair" do
    assert OnePair.is?(one_pair)
  end

  test "a non one pair hand should not return one pair" do
    assert !OnePair.is?(high_cards)
  end

  test "equal pairs should draw" do
    one_pair1 = Hand.create(one_pair)
    one_pair2 = Hand.create(one_pair_equal)
    assert one_pair1 == one_pair2
  end

  test "a high pair should win" do
    one_pair1 = Hand.create(one_pair)
    one_pair2 = Hand.create(one_pair_better)
    assert one_pair1 < one_pair2
  end

  test "equal pair with better kicker should win" do
    one_pair1 = Hand.create(one_pair)
    one_pair2 = Hand.create(one_pair_better_kicker)
    assert one_pair1 < one_pair2
  end
  
  # high cards ---------------------------------------------------------------
  test "a high cards hand should return a high cards" do
    assert HighCards.is?(high_cards)
  end
  
  test "a better high cards should win" do
    high_cards1 = Hand.create(high_cards)
    high_cards2 = Hand.create(high_cards_better)
    assert high_cards1 < high_cards2
  end

  test "a better high cards with same high cards should win" do
    high_cards1 = Hand.create(high_cards)
    high_cards2 = Hand.create(high_cards_better_lower)
    assert high_cards1 < high_cards2
  end

  private # ♡ ♣ ♠ ♢

  # striaght flush hands:
  def straight_flush
    [5.♠, 6.♠, 7.♠, 8.♠, 9.♠]
  end

  def straight_flush_better
    [6.♠, 7.♠, 8.♠, 9.♠, 10.♠]
  end

  # four of a kind hands:
  def four_of_a_kind
    [6.♠, Q.♡, Q.♠, Q.♣, Q.♢]
  end

  def four_of_a_kind_equal
    [6.♢, Q.♡, Q.♠, Q.♣, Q.♢]
  end

  def four_of_a_kind_better
    [6.♠, K.♡, K.♠, K.♣, K.♢]
  end

  def four_of_a_kind_better_kicker
    [7.♠, Q.♡, Q.♠, Q.♣, Q.♢]
  end

  # full house hands:
  def full_house
    [3.♠, 3.♡, 6.♠, 6.♣, 6.♢]
  end

  def full_house_equal
    [3.♣, 3.♢, 6.♠, 6.♣, 6.♢]
  end

  def full_house_better
    [6.♣, 6.♢, Q.♠, Q.♣, Q.♢]
  end
  
  # flush hands:
  def flush
    [7.♠, 6.♠, 9.♠, 10.♠, Q.♠]
  end

  def flush_better
    [7.♠, 6.♠, 9.♠, Q.♠, K.♠]
  end

  # straight hands:
  def straight
    [5.♠, 6.♡, 7.♠, 8.♣, 9.♢]
  end

  def straight_better
    [6.♠, 7.♡, 8.♠, 9.♣, 10.♢]
  end

  def straight_five_high
    [A.♠, 2.♡, 3.♠, 4.♣, 5.♢]
  end
  
  def non_consecutive_hand
    [A.♠, 2.♡, 4.♠, 4.♣, 5.♢]
  end
  
  def straight_ace_high
    [10.♠, J.♡, Q.♠, K.♣, A.♢]
  end

  # three of a kind hands:
  def three_of_a_kind_better_kicker
    [5.♠, 7.♡, J.♠, J.♣, J.♢]
  end
  def three_of_a_kind_better
    [5.♡, 6.♠, Q.♠, Q.♣, Q.♢]
  end
  def three_of_a_kind_equal
    [5.♡, 6.♠, J.♠, J.♣, J.♢]
  end
  def three_of_a_kind
    [5.♠, 6.♡, J.♠, J.♣, J.♢]
  end

  # two pair hands:
  def two_pair_better_kicker
    [4.♠, 7.♡, 7.♠, K.♣, K.♢]
  end
  
  def two_pair_better_low
    [3.♠, 8.♡, 8.♠, K.♣, K.♢]
  end

  def two_pair_better_high
    [3.♠, 7.♡, 7.♠, A.♣, A.♢]
  end

  def two_pair_equal
    [3.♠, 7.♡, 7.♠, K.♣, K.♢]
  end

  def two_pair
    [3.♣, 7.♣, 7.♢, K.♡, K.♠]
  end

  # one pair hands:
  def one_pair_better_kicker
    [3.♣, 7.♠, A.♡, Q.♡, Q.♠]
  end

  def one_pair_better
    [3.♣, 7.♠, 8.♡, A.♣, A.♢]
  end

  def one_pair_equal
    [3.♣, 7.♠, 8.♡, Q.♡, Q.♠]
  end

  def one_pair
    [3.♠, 7.♡, 8.♠, Q.♣, Q.♢]
  end

  # high cards
  def high_cards_better_lower
    [5.♢, 6.♠, 8.♣, 10.♡, J.♠]
  end

  def high_cards_better
    [5.♢, 6.♠, 8.♣, 9.♡, Q.♠]
  end

  def high_cards
    [5.♠, 6.♢, 8.♡, 9.♣, J.♠]
  end
end