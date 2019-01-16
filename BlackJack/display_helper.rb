# Lesson10 (BlackJack) Interface Display Class
#
class DisplayHelper
  attr_reader :cards

  def initialize
    @cards = []
  end

  def depicture(hand)
    cards.clear
    hand.cards.each do |card|
      card.shown? ? cards << [card.rank, card.suit].join("_of_") : cards << "*"
    end
    cards
  end
end
