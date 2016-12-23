require 'pry'
class Game
  attr_accessor :deck, :player_1, :player_2

  def initialize(player_1, player_2)
    @deck = Deck.new.cards
    @player_1 = player_1
    @player_2 = player_2
  end

  def play
    puts "Shuffling Deck..."
    @deck.shuffle!
    sleep(1)
    puts "Dealing Cards..."
    deal_cards(@player_1)
    deal_cards(@player_2)
    sleep(1)
    turn
  end

  def deal_cards(player)
    player.deck.push(@deck[0])
    @deck.shift
    player.deck.push(@deck[0])
    @deck.shift
  end

  def turn
    puts "We're now in the turn phase!"
  end

end
