# coding: UTF-8
module Poker
  class Card
    include Comparable
    attr_reader :value, :suit

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

    def eql?(other)
      @value == other.value && @suit == other.suit
    end

    def <=>(other)
      value_compare = value_compare(other)
      return value_compare unless value_compare == 0
      SUITS.index(other.suit) <=> SUITS.index(@suit)
    end
    
    def value_compare(other)
      VALUES.index(other.value) <=> VALUES.index(@value)
    end
    
    def hash
      to_s.hash
    end
    
    # shorthand for new hands:
    #
    # core extentions:
    #   4.of(:spades)
    #   9.of("diamonds")
    #   A.of(:clubs)
    #   8.hearts
    #   J.♡
    #   5.H
    module Shorthand
      def of(suit)
        Card.new(to_s.to_sym, suit.to_sym) unless (!check_suit(suit.to_sym) or !check_value)
      end

      Card::SUITS.each do |suit|
        define_method suit do
          Card.new(value, suit) unless !check_value
        end
        alias_method suit.to_s.upcase[0,1].to_sym, suit
        alias_method SUIT_CHARACTER[suit], suit
      end

      private

      def value
        to_s == "T" ? :"10" : to_s.to_sym
      end

      def check_suit(suit)
        Card::SUITS.include? suit
      end

      def check_value
        Card::VALUES.include? value
      end
    end

  end
end

class Fixnum
  include Poker::Card::Shorthand
end

class Symbol
  include Poker::Card::Shorthand
end

def Object.const_missing(sym)
  super unless [:A,:K,:Q,:J,:T].include? sym
  sym
end
