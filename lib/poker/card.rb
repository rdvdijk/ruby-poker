# coding: UTF-8
class Card
  attr_reader :value
  attr_reader :suit

  SUITS = [:hearts, :clubs, :spades, :diamonds]
  VALUES = [:"2",:"3",:"4",:"5",:"6",:"7",:"8",:"9",:"10", :J, :Q, :K, :A]
  SUIT_CHARACTER = {
    :hearts => "♡",
    :clubs => "♣", 
    :spades => "♠", 
    :diamonds => "♢"
  }
  
  def initialize(value, suit)
    raise ArgumentError.new("Illegal card value") unless VALUES.include? value
    raise ArgumentError.new("Illegal suit") unless SUITS.include? suit
    @value = value
    @suit = suit
  end
  
  def to_s
    "#{@value}#{SUIT_CHARACTER[@suit]}"
  end
  
  def inspect
    to_s
  end
end