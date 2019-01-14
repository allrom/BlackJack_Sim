# Lesson10 (BlackJack) Game Servicing Module
#
module GameService
  def self.included(base)
    base.send(:include, InstanceMethods)
  end

  module InstanceMethods
    def depicture(hand)
      cards = []
      hand.cards.each do |card|
        card.shown? ? cards << [card.rank, card.suit].join("_of_") : cards << "*"
      end
      cards
    end

    def two_cards?(hand)
      hand.tell_length == 2
    end

    def new_deck
      @deck = Deck.new
      deck.shuffle_deck
    end

    def new_banker
      @banker = Banker.new
    end

    def new_gamblers_hand
      @gamblers_hand = CardsInHand.new(gambler)
    end

    def new_dealers_hand
      @dealers_hand = CardsInHand.new(dealer)
    end
  end
end
