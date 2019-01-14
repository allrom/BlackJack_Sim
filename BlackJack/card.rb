# Lesson10 (BlackJack) A Card Class
#
class Card
  RANKS = %w[2 3 4 5 6 7 8 9 10 J Q K A].freeze
  SUITS = %w[clubs hearts spades diamonds].freeze
  CARD_VALUE = {
    "2" => 2, "3" => 3, "4" => 4,
    "7" => 7, "5" => 5, "6" => 6,
    "8" => 8, "9" => 9, "10" => 10,
    "A" => 11, "J" => 10,
    "Q" => 10, "K" => 10
  }.freeze

  attr_reader :rank, :suit, :value, :hidden

  def initialize(rank, suit, value)
    @rank = rank
    @suit = suit
    validate!
    @value = value
    @hidden = true
  end

  def hidden?
    @hidden
  end

  def shown?
    !hidden
  end

  def show!
    @hidden = false
  end

  protected

  def validate!
    raise ArgumentError, "Card Rank is wrong!" unless RANKS.include?(rank)
    raise ArgumentError, "Card Suit is wrong!" unless SUITS.include?(suit)
  end
end
