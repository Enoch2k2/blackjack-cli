class Game
  attr_accessor :deck, :player_1, :player_2, :dealer, :turn_count, :type

  def initialize(player_1, player_2=nil, dealer, type)
    @deck = Deck.new.cards
    @player_1 = player_1
    @player_2 = player_2 if player_2
    @dealer = dealer
    @type = type
    @turn_count = 0
  end

  def current_player
    if @turn_count == 0
      @player_1
    elsif @turn_count == 1 && @player_2
      @player_2
    else
      @dealer
    end
  end

  # def opposite_player
  #   current_player == @player_1 ? @player_2 : @player_1
  # end

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
        view_cards(player) if player.is_a?(Human)
        puts "Would you like the Ace of #{card.type} to equal 1 or 11? Type 1 or 11" if player.is_a?(Human)
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
  end

  def get_player_card_values(player)
    player.deck_value = 0
    player.deck.each{|card| player.deck_value += card_value(card, player)}
    player.deck_value
  end

  def draw?
    if @player_1.deck_value == @dealer.deck_value
      true
    elsif @player_2 && @player_1.deck_value > @player_2.deck_value && @player_1.deck_value == @dealer.deck_value
      true
    elsif @player_2 && @player_1.deck_value > @dealer.deck_value && @player_1.deck_value == @player_2.deck_value
      true
    elsif @player_2 && @player_2.deck_value > @player_1.deck_value && @player_2.deck_value == @dealer.deck_value
      true
    end
  end

  def bust(player)
    player.deck_value > 21
  end

  def two_player_won(player, player_2, player_3)
    if player.deck_value > player_2.deck_value && bust(player_3) && !bust(player) && !bust(player_2)
      player
    elsif player.deck_value > player_3.deck_value && bust(player_2) && !bust(player) && !bust(player_3)
      player
    elsif player.deck_value > player_2.deck_value && player.deck_value > player_3.deck_value && !bust(player) && !bust(player_2) && !bust(player_3)
      player
    elsif !bust(player) && bust(player_2) && bust(player_3)
      player
    end
  end

  def one_player_won(player_1, player_2)
    if player_1.deck_value > player_2.deck_value && !bust(player_1) && !bust(player_2)
      player_1
    elsif !bust(player_1) && bust(player_2)
      player_1
    end
  end

  def won?
    if @type == "2 player"
      if winner = two_player_won(@player_1, @player_2, @dealer)
        winner
      elsif winner = two_player_won(@player_2, @player_1, @dealer)
        winner
      elsif winner = two_player_won(@dealer, @player_1, @player_2)
        winner
      end
    else
      if winner = one_player_won(@player_1, @dealer)
        winner
      elsif winner = one_player_won(@dealer, @player_1)
        winner
      end
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
    elsif @player2 && bust(@player_2)
      puts "Player 2 busted!"
    elsif bust(@dealer)
      puts "Dealer busted!"
    end
  end

  def game_over
    @turn_count == 3 ? true : false
  end

  def show_hands
    view_cards(@player_1)
    puts "Total card value: #{@player_1.deck_value}#{bust(@player_1) ? ' - Busted!' : nil}"
    sleep(1)
    puts ""
    view_cards(@player_2) if @player_2
    puts "Total card value: #{@player_2.deck_value}#{bust(@player_2) ? ' - Busted!' : nil}" if @player_2
    puts ""
    view_cards(@dealer)
    puts "Total card value: #{@dealer.deck_value}#{bust(@dealer) ? ' - Busted!' : nil}"
    sleep(1)
    puts ""
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
    lost ? turn_count += 1 : nil
    view_cards(current_player) if current_player.is_a?(Human)
    get_player_card_values(current_player)
    puts "A total value of #{current_player.deck_value}" if current_player.is_a?(Human)
    puts "" if current_player.is_a?(Human)
    options
  end

  def update_player_values
    puts "Updating #{@player_1.name}'s hand..."
    sleep(1)
    get_player_card_values(@player_1)
    sleep(1)
    puts "Updating #{@player_2.name}'s hand..." if @player_2
    sleep(1) if @player_2
    get_player_card_values(@player_2) if @player_2
    sleep(1) if @player_2
    puts "Updating Dealer's hand..."
    sleep(1)
    get_player_card_values(@dealer)
    sleep(1)
  end

  def options
    puts "#{current_player.name} turn: Type hit to draw a card, stand to keep your hand, or help for more options!" if current_player.is_a?(Human)
    input = gets.strip if current_player.is_a?(Human)
    input = current_player.move if current_player.is_a?(Computer)
    puts ""
    case input
      when "hit"
        puts "#{current_player.name} draws a card!"
        puts ""
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
    deal_cards(@player_2) if @player_2
    deal_cards(@dealer)
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
    puts "Main Menu? Type 'menu', Play again? Type 'y' for yes or 'n' for no:"
    input = gets.strip

    case input
      when "menu"
        puts ""
        Cli.new.initialize_players
      when "y"
        puts ""
        if @type == "1 player"
          @player_1 = Human.new(@player_1.name)
          @dealer = Computer.new
          Game.new(@player_1, @dealer, "1 player").play
        else
          @player_1 = Human.new(@player_1.name)
          @player_2 = Human.new(@player_2.name)
          @dealer = Computer.new
          Game.new(@player_1, @player_2, @dealer, "2 player").play
        end
      when "n"
        return
      else
        puts ""
        Cli.new.error_message
        end_game
    end
  end

end
