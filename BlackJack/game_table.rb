# Lesson10 (BlackJack) Game Control Class
#
class GameTable
  include GameTech
  include GameService

  attr_reader :interface, :gambler, :dealer, :banker,
              :gamblers_hand, :dealers_hand, :deck

  def initialize(interface)
    @interface = interface
    name = interface.greeting
    @gambler = Gambler.new(name)
    @dealer = Dealer.new
    @gamblers_hand = CardsInHand.new(gambler)
    @dealers_hand = CardsInHand.new(dealer)
    @banker = Banker.new
  end

  def play
    start_over if credit_check
    gambler_play(:start_menu) while interface.go_on?
  end

  def start_over
    new_gamblers_hand
    new_dealers_hand
    banker.getbet
    round_start
  end

  def round_start
    new_deck
    start_deal
    interface.display_credit(gambler.name, banker.gambler_credit)
    gambler_your_cards
    dealer_your_cards

    gamblers_score = gamblers_hand.tell_score
    interface.display_score(gambler.name, gamblers_score)
    interface.blackjack(gambler.name) if blackjack?(gamblers_score)
  end

  def start_deal
    deal(2, gambler, gamblers_hand, deck)
    deal(2, dealer, dealers_hand, deck)
  end

  def round_end
    interface.showdown
    showdown(dealers_hand)
    gambler_your_cards
    dealer_your_cards
    final_score

    status, winner = who_won(gamblers_hand, dealers_hand)
    gambler_credit, dealer_credit = banker.processing(status, winner)
    win_name = winner == :gambler ? gambler.name : :dealer
    interface.display_fin(status, win_name, gambler.name, gambler_credit, dealer_credit)

    play if interface.again?
  end

  def final_score
    gamblers_score = gamblers_hand.tell_score
    dealers_score = dealers_hand.tell_score

    if blackjack?(gamblers_score)
      interface.blackjack(gambler.name)
    else
      interface.display_score(gambler.name, gamblers_score)
    end
    if blackjack?(dealers_score)
      interface.blackjack(:dealer)
    else
      interface.display_score(:dealer, dealers_score)
    end
  end

  def gambler_your_cards
    gamblers_cards = depicture(gamblers_hand)
    interface.display_card(gambler.name, gamblers_cards)
  end

  def dealer_your_cards
    dealers_cards = depicture(dealers_hand)
    interface.display_card(:dealer, dealers_cards)
  end

  def mad?(player)
    lose_name = player.role == :gambler ? gambler.name : :dealer
    banker.lost_money?(player) && interface.question_credit(lose_name)
  end

  def credit_check
    return true if banker.money?(gambler) && banker.money?(dealer)

    new_banker if mad?(gambler) || mad?(dealer)
  end

  def gambler_play(menu_items)
    select = interface.gambler_select(gambler.name, menu_items)
    case select
    when :pass then dealer_play
    when :take_a_card
      gambler_takes_card
      gambler_your_cards
      dealer_play
    when :showdown then round_end
    end
  end

  def gambler_takes_card
    if blackjack?(gamblers_hand.tell_score)
      return interface.blackjack(gambler.name)
    end

    deal(1, gambler, gamblers_hand, deck)
  end

  def dealer_play
    interface.player_hit(:dealer)
    if dealer.decide?(dealers_hand) && two_cards?(dealers_hand)
      deal(1, dealer, dealers_hand, deck)
    end
    dealer_your_cards
    gambler_play_next
  end

  def gambler_play_next
    if two_cards?(gamblers_hand) && no_blackjack?(gamblers_hand.tell_score)
      gambler_your_cards
      gambler_play(:next_menu)
    else
      round_end
    end
  end
end
