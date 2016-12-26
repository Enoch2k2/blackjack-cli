class Cli
  def run
    puts "Welcome to Blackjack Cli!"
    initialize_players
  end

  def error_message
    puts "Incorrect input, please try again!"
  end

  def clear_screen
    system 'clear' or system 'cls'
  end

  def initialize_game
    clear_screen
    puts "Type start to begin or exit to exit program"
    input = gets.strip
    case input
      when "start"
        clear_screen
        puts "Loading Game..."
        sleep(2)
        game = Game.new(@player_1, @player_2, @dealer, @type) if @player_2
        game = Game.new(@player_1, @dealer, @type) if !@player_2
        clear_screen
        puts "Game loaded"
        sleep(1)
        clear_screen
        game.play
      when "exit"
        return
      else
        error_message
        initialize_game
    end
  end

  def ask_for_player1_name
    clear_screen
    puts "Player 1, What is your name?"
    input = gets.strip
    @player_1 = Human.new(input)
    @type = "1 player"
  end

  def ask_for_player2_name
    clear_screen
    puts "Player 2, What is your name?"
    input = gets.strip
    @player_2 = Human.new(input)
    @type = "2 player"
  end

  def initialize_players
    puts "Type 1 for 1 player, 2 for 2 players, or exit to exit:"
    input = gets.strip
    puts ""
    case input
      when "1"
        ask_for_player1_name
        @dealer = Computer.new
        initialize_game
      when "2"
        ask_for_player1_name
        puts ""
        ask_for_player2_name
        puts ""
        @dealer = Computer.new
        initialize_game
      when "exit"
        return
      else
        error_message
        initialize_players
    end
  end

end
