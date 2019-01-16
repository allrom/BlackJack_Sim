# Lesson10 (BlackJack) A Player Class
#
class Player
  attr_reader :role, :hand

  def initialize(role)
    @role = role
    new_hand
  end

  def new_hand
    @hand = Hand.new
  end
end
