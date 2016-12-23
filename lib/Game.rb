require 'pry'
class Game
  attr_accessor :deck, :player_1, :player_2, :turn_count

  def initialize(player_1, player_2)
    @deck = Deck.new.cards
    @player_1 = player_1
    @player_2 = player_2
    @turn_count = 0
  end

  def current_player
    @turn_count % 2 == 0 ? @player_1 : @player_2
  end

  def play
    puts "Shuffling Deck..."
    @deck.shuffle!
    sleep(1)
    puts "Dealing Cards..."
    deal_cards(@player_1)
    deal_cards(@player_2)
    sleep(1)
    view_cards
    turn
  end

  def deal_cards(player)
    player.deck.push(@deck[0])
    @deck.shift
    player.deck.push(@deck[0])
    @deck.shift
  end

  def hit(player)
    player.deck.push(@deck[0])
    @deck.shift
    @turn_count += 1
  end

  def help
    puts "Type cards to see your cards, exit to exit game, menu to go back to the menu"
  end

  def view_cards
    current_player.deck.each{|card| puts "#{card.name} - #{card.type}"}
  end

  def turn
    puts "#{current_player.name} turn: Type hit to draw a card or help for more options!"
    input = gets.strip
    case input
      when "hit"
        hit(current_player)
      when "help"
        help
        puts "Press Enter to continue:"
        gets.strip
        turn
      when "cards"
        view_cards
        puts "Press Enter to continue:"
        gets.strip
        turn
      when "exit"
        return
      when "menu"
        Cli.new.initialize_players
      else
        Cli.new.error_message
        turn
    end
  end

end
