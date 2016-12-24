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

  def card_value(card, player=current_player)
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
        view_cards(player)
        puts "Would you like the Ace of #{card.type} to equal 1 or 11? Type 1 or 11"
        input = gets.strip if player.is_a?(Human)
        input = player.get_ace_value if player.is_a?(Computer)
        case input
          when "1"
            return 1
          when "11"
            return 11
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
    get_player_card_values(player)
    @deck.shift
    @turn_count += 1
  end

  def get_player_card_values(player)
    player.deck_value = 0
    player.deck.each{|card| player.deck_value += card_value(card, player)}
    player.deck_value
  end

  def draw?
    @player_1.deck_value == @player_2.deck_value
  end

  def bust(player)
    player.deck_value > 21
  end

  def won?
    if @player_1.deck_value > @player_2.deck_value && !bust(@player_1)
      @player_1
    elsif @player_2.deck_value > @player_1.deck_value && !bust(@player_2)
      @player_2
    elsif bust(@player_1) && !bust(@player_2)
      @player_2
    elsif bust(@player_2) && !bust(@player_1)
      @player_1
    end
  end

  def winner
    if winner = won?
      winner
    end
  end

  def lost
    if bust(@player_1)
      puts "Player 1 busted!"
    elsif bust(@player_2)
      puts "Player 2 busted!"
    end
  end

  def game_over
    if @player_1.status == "stand" && @player_2.status == "stand"
      true
    elsif bust(@player_1) || bust(@player_2)
      true
    end
  end

  def show_hands
    view_cards(@player_1)
    puts "Total card value: #{@player_1.deck_value}#{bust(@player_1) ? ' - Busted!' : nil}"
    sleep(1)
    puts ""
    view_cards(@player_2)
    puts "Total card value: #{@player_2.deck_value}#{bust(@player_2) ? ' - Busted!' : nil}"
  end

  def stand(player)
    player.status = "stand"
  end

  def help
    puts "Type cards to see your cards, exit to exit game, menu to go back to the menu"
    puts ""
  end

  def view_cards(player)
    puts "#{player.name}'s cards:"
    player.deck.each{|card| puts "#{card.name} of #{card.type}"}
    puts ""
  end

  def turn
    @turn_count += 1 if current_player.status == "stand"
    view_cards(current_player)
    get_player_card_values(current_player)
    puts "A total value of #{current_player.deck_value}"
    puts ""
    options
  end

  def update_player_values
    puts "Updating #{@player_1.name}'s hand..."
    sleep(1)
    get_player_card_values(@player_1)
    sleep(1)
    puts "Updating #{@player_2.name}'s hand..."
    sleep(1)
    get_player_card_values(@player_2)
    sleep(1)
  end

  def options
    puts "#{current_player.name} turn: Type hit to draw a card, stand to keep your hand, or help for more options!"
    input = gets.strip if current_player.is_a?(Human)
    input = current_player.move if current_player.is_a?(Computer)
    puts ""
    case input
      when "hit"
        hit(current_player)
      when "help"
        help
        options
      when "cards"
        view_cards(current_player)
        puts "A total value of #{current_player.deck_value}"
        puts ""
        options
      when "exit"
        exit
      when "menu"
        Cli.new.initialize_players
      when "stand"
        puts "#{current_player.name} stands!"
        puts ""
        stand(current_player)
        @turn_count += 1
      else
        Cli.new.error_message
        turn
    end
  end

  def play
    puts "Shuffling Deck..."
    @deck.shuffle!
    sleep(1)
    puts "Dealing Cards..."
    deal_cards(@player_1)
    deal_cards(@player_2)
    sleep(1)
    update_player_values
    puts ""
    until game_over
      turn
    end
    puts "Players, show your hands!"
    puts ""
    sleep(1)
    show_hands
    sleep(1)
    puts ""

    if won?
      puts "Congratulations #{winner.name}. You won with #{winner.deck_value}!"
    elsif draw?
      puts "The game ends in a draw!"
    else
      lost
    end
    sleep(1)
    puts ""
    end_game
  end

  def end_game
    puts "Play again? y/n"
    input = gets.strip

    case input
      when "y"
        Cli.new.initialize_players
      when "n"
        return
      else
        Cli.new.error_message
        end_game
    end
  end

end
