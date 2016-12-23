class Player
  attr_accessor :deck, :name

  def initialize(name="AI")
    @deck = []
    @name = name
  end
end
