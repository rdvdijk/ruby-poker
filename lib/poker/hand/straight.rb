module Poker
  class Straight < Hand
    # find positions in ordered values array, 
    # difference between min and max should be exactly 4
    def self.is?(cards)
      value_positions = value_positions(cards)
      return false if (value_positions.max - value_positions.min != 4)
      HighCards.is?(cards) # no pairs
    end

    # compare the value of the highest card
    def <=>(other)
      return super if self.class != other.class
      value_positions = Straight.value_positions(@cards)
      other_positions = Straight.value_positions(other.cards)
      value_positions.max <=> other_positions.max
    end

    # get the positions (=value) of the cards, keeping a 5-high straight in mind
    def self.value_positions(cards)
      value_positions = cards.inject([]) do |array,card|
        array << Card::VALUES.index(card.value)
        array
      end

      # special case: Ace, change position to -1 if a '2' i present
      if value_positions.include?(0) && value_positions.include?(Card::VALUES.size-1)
        value_positions[value_positions.index(Card::VALUES.size-1)] = -1
      end
      
      value_positions
    end
  end
end