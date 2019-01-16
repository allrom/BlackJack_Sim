# Lesson10 (BlackJack) Cards In Player's Hand
#
class Hand
  attr_accessor :cards

  def initialize
    @cards = []
  end

  def tell_score
    @total = @aces = 0
    cards.each do |card|
      if card.rank == "A"
        @aces += 1
        @total += 11
      else
        @total += card.value
        ## @total += CARD_VALUE[card.rank]
      end
    end
    while @total > GameTech::BLACKJACK && @aces.positive?
      @total -= 10
      @aces -= 1
    end
    @total
  end

  def tell_length
    cards.size
  end
end
