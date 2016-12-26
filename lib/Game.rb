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

  def check_for_ace(card, player)
    if card.name == "Ace" && card.value && player.is_a?(Human)
      view_cards(player)
      puts ""
      puts "Total value of #{player.deck_value}"
      puts ""
      puts "You have an Ace in your hand. Would you like to change it's value? Current value #{card.value} : y/n"
      input = gets.strip
      case input
        when 'y'
          puts "Would you like it's value to be 1 or 11?"
          input = gets.strip
          case input
            when '1'
              card.value = 1
            when '11'
              card.value = 11
            else
              Cli.new.error_message
              check_for_ace(card)
          end
        when 'n'
          card.value
        else
          Cli.new.error_message
          check_for_ace(card, player)
      end
    elsif card.name == "Ace" && player.is_a?(Human)
      clear_screen
      view_cards(player)
      puts "You have an Ace in your hand. Would you like it's value to be 1 or 11?"
      input = gets.strip
      case input
        when '1'
          card.value = 1
        when '11'
          card.value = 11
        else
          Cli.new.error_message
          check_for_ace(card)
      end
    elsif card.name == "Ace" && player.is_a?(Computer)
      card.value = player.get_ace_value
    end
  end

  def start_of_turn_values(player)
    player.deck_value = 0
    player.deck.each{|card| player.deck_value += card.value}
  end

  def get_card_values(player)
    player.deck_value = 0
    player.deck.each{|card| check_for_ace(card, player)}
    player.deck.each{|card| player.deck_value += card.value}
  end

  def deal_cards(player)
    player.deck.push(@deck[0])
    @deck.shift
    player.deck.push(@deck[0])
    @deck.shift
  end

  def hit(player)
    player.deck.push(@deck[0])
    get_card_values(player)
    @deck.shift
  end

  def clear_screen
    Cli.new.clear_screen
  end

  def get_player_card_values(player)
    player.deck_value = 0
    player.deck.each{|card| player.deck_value += card.value}
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

  def game_over
    return true if @turn_count == 3 if @player_2
    return true if @turn_count == 2 if !@player_2

  end

  def show_hands
    view_cards(@player_1)
    puts "Total card value: #{@player_1.deck_value}#{bust(@player_1) ? ' - Busted!' : nil}"
    sleep(1)
    puts ""
    view_cards(@player_2) if @player_2
    puts "Total card value: #{@player_2.deck_value}#{bust(@player_2) ? ' - Busted!' : nil}" if @player_2
    puts "" if @player_2
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
    clear_screen
    view_cards(current_player) if current_player.is_a?(Human)
    start_of_turn_values(current_player)
    puts "A total value of #{current_player.deck_value}" if current_player.is_a?(Human)
    puts "" if current_player.is_a?(Human)
    options
  end

  def update_player_values
    puts "Updating #{@player_1.name}'s hand..."
    sleep(1)
    clear_screen
    get_card_values(@player_1)
    sleep(1)
    clear_screen if @player_1.deck.detect {|x| x if x.name == "Ace"}
    puts "Updating #{@player_2.name}'s hand..." if @player_2
    sleep(1) if @player_2
    clear_screen if @player_2
    get_card_values(@player_2) if @player_2
    sleep(1) if @player_2
    clear_screen if @player_2 && @player_2.deck.detect {|x| x if x.name == "Ace"}
    puts "Updating Dealer's hand..."
    sleep(1)
    get_card_values(@dealer)
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
        sleep(2)
        hit(current_player)
        get_card_values(current_player)
        if bust(current_player)
          puts current_player.name + " busts!"
          @turn_count += 1          
          sleep(1)
        end
      when "help"
        clear_screen
        help
        options
      when "cards"
        clear_screen
        view_cards(current_player)
        puts "A total value of #{current_player.deck_value}"
        get_card_values(current_player)
        options
      when "exit"
        exit
      when "menu"
        Cli.new.initialize_players
      when "stand"
        puts "#{current_player.name} stands!"
        sleep(2)
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
    clear_screen
    puts "Dealing Cards..."
    deal_cards(@player_1)
    deal_cards(@player_2) if @player_2
    deal_cards(@dealer)
    sleep(1)
    clear_screen
    update_player_values
    until game_over
      turn
    end
    clear_screen
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
        clear_screen
        Cli.new.initialize_players
      when "y"
        clear_screen
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
        clear_screen
        Cli.new.error_message
        end_game
    end
  end

end
