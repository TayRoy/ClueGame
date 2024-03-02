require_relative "Player"
require_relative "Card"
require_relative "Guess"
require_relative "Model"
require_relative "InteractivePlayer"

puts("Welcome to \"whodunnit?\"")
people = [
  Card.new(:person,"Steve"),
  Card.new(:person,"Allen"),
  Card.new(:person,"Margaret"),
  Card.new(:person,"Sarah"),
  Card.new(:person,"Kyle"),
  Card.new(:person,"Harold"),
  Card.new(:person,"Anthony"),
  Card.new(:person,"Vanessa"),
  Card.new(:person,"Dianne")

  ]

places = [
  Card.new(:place,"Library"),
  Card.new(:place,"Kitchen"),
  Card.new(:place,"Dining Room"),
  Card.new(:place,"Bathroom"),
  Card.new(:place,"Basement")
  ]

weapons = [
  Card.new(:weapon,"gun"),
  Card.new(:weapon,"knife"),
  Card.new(:weapon,"candlestick"),
  Card.new(:weapon,"poison"),
  ]

o = Model.new(people,places,weapons)
puts("How many computer opponents would you like?")
numPlayers = gets.chomp.to_i

players = Array.new(numPlayers+1)
(numPlayers).times { |i| players[i] = Player.new() }
players[numPlayers] = InteractivePlayer.new()

puts("Setting up players..")
o.setPlayers(players)
puts("Dealing cards..")
o.setupCards()
puts("Playing...")
o.play()
puts ("Game over")
