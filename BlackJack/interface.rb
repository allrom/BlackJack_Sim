# Lesson10 (BlackJack) An Interface Class
#
class Interface
  GAMBLER_MENU_HEADER = "\n * Selection Menu. Enter correct menu digit *\n"
  GAMBLER_MENU_START = <<-MENU.freeze
    1:  Pass (Stay)
    2:  Take one card
  MENU
  GAMBLER_MENU_NEXT = <<-MENU.freeze
    2:  Take one card
    3:  Showdown cards
  MENU

  GAMBLER_SELECT = {
    1 => :pass,
    2 => :take_a_card,
    3 => :showdown
  }.freeze

  def initialize
    puts "\n\t * BlackJack Game simulator *"
    @play = true
  end

  def go_on?
    @play
  end

  def greeting
    attempt ||= 0
    puts "\n > Enter Your Name (or play as \"Gambler\"): "
    name = gets.strip
    while name.empty?
      if (attempt += 1) <= 2
        puts("\tTry again, empty field")
        name = gets.strip
      else
        name = 'Gambler'
      end
    end
    name
  end

  def display_card(player, hand)
    puts "\n\tPlayer #{player} got these cards: "
    hand.each { |card| print " | #{card}" }
    print " |\n"
  end

  def display_score(player, score)
    puts "\n\tPlayer #{player} got #{score} points"
  end

  def display_credit(player, money)
    puts "\n\tPlayer #{player} has #{money} credits"
  end

  def display_fin(status, winner, player, player_credit, dealer_credit)
    case status
    when :win
      puts "\n\t > Mr. #{winner}, you Won!"
    when :bust
      loser = winner == :dealer ? player : "Dealer"
      puts "\n\t > Mr. #{winner}, you Won! Player #{loser} got Busted."
    when :tie
      puts "\n\t > Players, it's a Tie."
    end
    puts "\n\t > Players, here your banks:"
    print "\t " + "-" * 27 + "\n"
    puts "\t > for #{player} #{player_credit}, for Dealer #{dealer_credit}"
  end

  def question_credit(player)
    puts "\n\tPlayer #{player} had lost all credits..."
    again?
  end

  def again?
    puts "\n > Wanna play again? Type \"Y\" or \"N\""
    play_again = gets.strip
    until %w[Y N].include?(play_again.upcase)
      puts "\t > Type \"Y\" or \"N\""
      play_again = gets.strip
    end
    if play_again.casecmp("N").zero?
      puts " Tanks for BlackJack..."
      @play = false
      false
    else
      print " New Round > " + "=" * 22 + "\n"
      true
    end
  end

  def gambler_select(player, menu)
    player_hit(player)
    puts GAMBLER_MENU_HEADER
    if menu == :start_menu
      puts GAMBLER_MENU_START
      menu_nums = [1, 2]
    else
      puts GAMBLER_MENU_NEXT
      menu_nums = [2, 3]
    end
    selector = gets.to_i
    until menu_nums.include?(selector)
      puts "\t > Type correct digit."
      selector = gets.to_i
    end
    GAMBLER_SELECT[selector]
  end

  def player_hit(player)
    puts "\n\t > Mr. #{player}, your turn."
  end

  def blackjack(player)
    puts "\n\t > Mr. #{player}, you got \"BlackJack\"!"
  end

  def showdown
    puts "\n\t > Players, here your cards (showdown):"
  end
end
