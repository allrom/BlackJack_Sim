# Lesson10 (BlackJack) All Things Starter
#
require_relative 'card'
require_relative 'deck'
require_relative 'cards_in_hand'
require_relative 'player.rb'
require_relative 'gambler.rb'
require_relative 'dealer.rb'
require_relative 'banker.rb'
require_relative 'game_tech.rb'
require_relative 'game_service.rb'
require_relative 'game_table.rb'
require_relative 'interface.rb'

croupier = Interface.new
game_flow = GameTable.new(croupier)
game_flow.play
