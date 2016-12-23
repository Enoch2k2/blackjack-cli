class Player
  attr_accessor :deck, :name, :deck_value, :status

  def initialize(name="Dealer")
    @deck = []
    @name = name
    @deck_value = 0
    @status = "playing"
  end
end
