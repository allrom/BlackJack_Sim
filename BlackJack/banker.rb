# Lesson10 (BlackJack) A Banker Class
#
class Banker
  START_CREDIT = 100
  BET = 10

  attr_reader :gambler_credit, :dealer_credit, :bank

  def initialize
    @bank = 0
    @gambler_credit = START_CREDIT
    @dealer_credit = START_CREDIT
  end

  def getbet
    @dealer_credit -= BET
    @gambler_credit -= BET
    @bank += 2 * BET
  end

  def pot(player)
    player == :gambler ? @gambler_credit += bank : @dealer_credit += bank
    @bank = 0
  end

  def tie
    @gambler_credit += bank / 2
    @dealer_credit += bank / 2
    @bank = 0
  end

  def money?(player)
    player.role == :gambler ? gambler_credit.positive? : dealer_credit.positive?
  end

  def lost_money?(player)
    !money?(player)
  end
end
