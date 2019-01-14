# Lesson10 (BlackJack) Game Process Module
#
module GameTech
  BLACKJACK = 21

  def self.included(base)
    base.send(:include, InstanceMethods)
  end

  module InstanceMethods
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

    def who_won(*hands)
      player1_score = hands.first.tell_score
      player2_score = hands.last.tell_score
      return :tie if fair_tie(player1_score, player2_score)

      if busted?(player2_score)
        status = :bust
        winner = hands.first.player.role
      elsif busted?(player1_score)
        status = :bust
        winner = hands.last.player.role
      elsif player1_score > player2_score
        status = :win
        winner = hands.first.player.role
      else
        status = :win
        winner = hands.last.player.role
      end
      [status, winner]
    end

    def showdown(hand)
      showdown!(hand)
    end

    protected

    def show_card!(card, player)
      card.show! if player.role == :gambler
    end

    def showdown!(hand)
      hand.cards.each(&:show!)
    end
  end
end
