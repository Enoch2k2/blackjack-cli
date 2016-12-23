class Player
  attr_accessor :deck, :name, :deck_value

  def initialize(name="Dealer")
    @deck = []
    @name = name
    @deck_value = 0
  end
end
