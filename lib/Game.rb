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

  def opposite_player
    current_player == @player_1 ? @player_2 : @player_1
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

  def card_value(card)
    case card.name
      when "1"
        return 1
      when "2"
        return 2
      when "3"
        return 3
      when "4"
        return 4
      when "5"
        return 5
      when "6"
        return 6
      when "7"
        return 7
      when "8"
        return 8
      when "9"
        return 9
      when "10"
        return 10
      when "Jack"
        return 10
      when "Queen"
        return 10
      when "King"
        return 10
      when "Ace"
        puts "Your cards are: "
        sleep(1)
        view_cards
        sleep(1)
        puts ""
        puts "A total value of #{current_player.deck_value}"
        sleep(1)
        puts ""
        puts "Would you like the Ace of #{card.type} to equal 1 or 10? Type 1 or 10"
        input = gets.strip
        case input
          when "1"
            return 1
          when "10"
            return 10
          else
            Cli.new.error_message
            card_value(card)
        end
      else
        Cli.new.error_message
        card_value(card)
    end
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

  def get_player_card_values
    @player_1.deck_value = 0
    @player_2.deck_value = 0
    @player_1.deck.each{|card| @player_1.deck_value += card_value(card)}
    @player_2.deck.each{|card| @player_2.deck_value += card_value(card)}
    puts "Total card value: #{current_player.deck_value}"
  end

  # def game_over
  #
  # end

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
        get_player_card_values
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
