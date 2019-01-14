# Lesson10 (BlackJack) A Gambler Class
#
class Gambler < Player
  attr_reader :name

  def initialize(name)
    @name = name
    super :gambler
  end
end
