# Lesson10 (BlackJack) Game Control Class
#
class GameTable
  include GameTech

  attr_reader :interface, :gambler, :dealer, :banker, :deck

  def initialize(interface)
    @interface = interface
    name = interface.greeting
    @gambler = Gambler.new(name)
    @dealer = Dealer.new
    @banker = Banker.new
  end

  def play
    start_over
    gambler_play(:start_menu) while interface.go_on?
  end

  def start_over
    gambler.new_hand
    dealer.new_hand
    banker.getbet
    round_start
  end

  def round_start
    new_deck
    start_deal
    interface.display_credit(gambler.name, banker.gambler_credit)
    gambler_your_cards
    dealer_your_cards

    gamblers_score = gambler.hand.tell_score
    interface.display_score(gambler.name, gamblers_score)
    interface.blackjack(gambler.name) if blackjack?(gamblers_score)
  end

  def start_deal
    deal(2, gambler, gambler.hand, deck)
    deal(2, dealer, dealer.hand, deck)
  end

  def round_end
    interface.showdown
    showdown(dealer)
    gambler_your_cards
    dealer_your_cards
    final_score

    status, winner = who_won(gambler, dealer)
    gambler_credit, dealer_credit = processing(status, winner)
    win_name = winner == :gambler ? gambler.name : :dealer
    interface.display_fin(status, win_name, gambler.name, gambler_credit, dealer_credit)

    start_over if interface.again? && credit_check
  end

  def final_score
    gamblers_score = gambler.hand.tell_score
    dealers_score = dealer.hand.tell_score

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
    interface.display_card(gambler.name, gambler.hand)
  end

  def dealer_your_cards
    interface.display_card(:dealer, dealer.hand)
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
    if blackjack?(gambler.hand.tell_score)
      return interface.blackjack(gambler.name)
    end

    deal(1, gambler, gambler.hand, deck)
  end

  def dealer_play
    interface.player_hit(:dealer)
    if dealer.decide?(dealer.hand) && two_cards?(dealer.hand)
      deal(1, dealer, dealer.hand, deck)
    end
    dealer_your_cards
    gambler_play_next
  end

  def gambler_play_next
    if two_cards?(gambler.hand) && no_blackjack?(gambler.hand.tell_score)
      gambler_your_cards
      gambler_play(:next_menu)
    else
      round_end
    end
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
end
