require File.expand_path("../test_helper", File.dirname(__FILE__))

class PotTest < ActiveSupport::TestCase
  def setup
    @pot = Pot.new
  end
  
  test "a new pot should be empty" do
    assert_equal 0, @pot.size
  end
  
  test "a new pot should not have any players" do
    assert_equal 0, @pot.players.size
  end
  
  test "adding an initial amount to the pot should set the pot size" do
    @pot.add 10
    assert_equal 10, @pot.size
  end

  test "adding an multiple amounts to the pot should set the correct pot size" do
    @pot.add 10
    @pot.add 20
    assert_equal 30, @pot.size
  end

  test "paying out to one player should add the pot to his stack" do
    @pot.add 10
    player = Player.new("John")
    initial_stack = player.stack
    @pot.pay_out(player)
    assert_equal initial_stack+10, player.stack
  end

  test "paying out to multiple players should not spill anything" do
    @pot.add 10
    player1 = Player.new("John")
    player2 = Player.new("Paul")
    initial_stack1 = player1.stack
    initial_stack2 = player1.stack
    @pot.pay_out(player1, player2)
    assert_equal initial_stack1+initial_stack2+10, player1.stack+player2.stack
  end

  test "paying out to multiple players should equally divide the pot" do
    @pot.add 10
    player1 = Player.new("John")
    player2 = Player.new("Paul")
    initial_stack1 = player1.stack
    initial_stack2 = player1.stack
    @pot.pay_out(player1, player2)
    assert_equal 1005, player1.stack
    assert_equal 1005, player2.stack
  end
  
end