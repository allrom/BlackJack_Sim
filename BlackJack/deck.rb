# Lesson10 (BlackJack) A Deck of Cards Class
#
class Deck
  attr_reader :cards

  def initialize
    @cards = []
  end

  def shuffle_deck
    shuffled_deck = Card::RANKS.product(Card::SUITS).shuffle
    shuffled_deck.each do |card|
      rank = card.first
      suit = card.last
      value = Card::CARD_VALUE[rank]
      @cards << Card.new(rank, suit, value)
    end
  end
end
