# Lesson10 (BlackJack) Game Process Module
#
module GameTech
  BLACKJACK = 21

  def deal(number, player, hand, deck)
    number.times do
      card = deck.cards.shift
      show_card!(card, player)
      hand.cards << card
    end
  end

  def busted?(score)
    score > BLACKJACK
  end

  def blackjack?(score)
    score == BLACKJACK
  end

  def no_blackjack?(score)
    !blackjack?(score)
  end

  def fair_tie(score1, score2)
    both_busted = busted?(score1) && busted?(score2)
    both_blackjack = blackjack?(score1) && blackjack?(score2)
    both_under = score1 == score2

    [both_busted, both_blackjack, both_under].any?
  end

  def who_won(*players)
    player1_score = players.first.hand.tell_score
    player2_score = players.last.hand.tell_score
    return :tie if fair_tie(player1_score, player2_score)

    if busted?(player2_score)
      status = :bust
      winner = players.first.role
    elsif busted?(player1_score)
      status = :bust
      winner = players.last.role
    elsif player1_score > player2_score
      status = :win
      winner = players.first.role
    else
      status = :win
      winner = players.last.role
    end
    [status, winner]
  end

  def processing(status, player)
    case status
    when :win, :bust then banker.pot(player)
    when :tie then banker.tie
    end
    [banker.gambler_credit, banker.dealer_credit]
  end

  def showdown(player)
    showdown!(player)
  end

  protected

  def show_card!(card, player)
    card.show! if player.role == :gambler
  end

  def showdown!(player)
    player.hand.cards.each(&:show!)
  end
end
