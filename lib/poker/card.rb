# coding: UTF-8
module Poker
  class Card
    include Comparable
    attr_reader :rank, :suit

    SUITS = [:hearts, :clubs, :spades, :diamonds]
    RANKS = [:"2",:"3",:"4",:"5",:"6",:"7",:"8",:"9",:"10", :J, :Q, :K, :A]
    SUIT_CHARACTER = {
      :hearts => "♡",
      :clubs => "♣", 
      :spades => "♠", 
      :diamonds => "♢"
    }
  
    def initialize(rank, suit)
      raise ArgumentError.new("Illegal card rank") unless RANKS.include? rank
      raise ArgumentError.new("Illegal suit") unless SUITS.include? suit
      @rank = rank
      @suit = suit
    end
  
    def to_s
      "#{@rank}#{SUIT_CHARACTER[@suit]}"
    end
  
    def inspect
      to_s
    end

    def eql?(other)
      @rank == other.rank && @suit == other.suit
    end

    def <=>(other)
      rank_compare = rank_compare(other)
      return rank_compare unless rank_compare == 0
      SUITS.index(other.suit) <=> SUITS.index(@suit)
    end
    
    def rank_compare(other)
      RANKS.index(other.rank) <=> RANKS.index(@rank)
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
        Card.new(to_s.to_sym, suit.to_sym) unless (!check_suit(suit.to_sym) or !check_rank)
      end

      Card::SUITS.each do |suit|
        define_method suit do
          Card.new(rank, suit) unless !check_rank
        end
        alias_method suit.to_s.upcase[0,1].to_sym, suit
        alias_method SUIT_CHARACTER[suit], suit
      end

      private

      def rank
        to_s == "T" ? :"10" : to_s.to_sym
      end

      def check_suit(suit)
        Card::SUITS.include? suit
      end

      def check_rank
        Card::RANKS.include? rank
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
