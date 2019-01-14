# Lesson10 (BlackJack) A Dealer Class
#
class Dealer < Player
  DEALER_PASS = 17

  def initialize
    super :dealer
  end

  def decide?(hand)
    hand.tell_score < DEALER_PASS
  end
end
