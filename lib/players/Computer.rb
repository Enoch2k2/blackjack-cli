class Computer < Player
  def move
    if @deck_value < 15
      return "hit"
    else
      return "stand"
    end
  end

  def get_ace_value
    @deck_value = 0
    @deck.each{|card| @deck_value += card.value if card.value}
    if @deck_value < 11
      return 11
    else
      return 1
    end
  end
end
