class Deck
  attr_accessor :cards

  def initialize
    @cards = get_all_cards
  end

  def get_all_cards
    [
      Card.new('Ace', 'Heart'),
      Card.new('Ace', 'Diamond'),
      Card.new('Ace', 'Clover'),
      Card.new('Ace', 'Spade'),
      Card.new('2', 'Heart'),
      Card.new('2', 'Diamond'),
      Card.new('2', 'Clover'),
      Card.new('2', 'Spade'),
      Card.new('3', 'Heart'),
      Card.new('3', 'Diamond'),
      Card.new('3', 'Clover'),
      Card.new('3', 'Spade'),
      Card.new('4', 'Heart'),
      Card.new('4', 'Diamond'),
      Card.new('4', 'Clover'),
      Card.new('4', 'Spade'),
      Card.new('5', 'Heart'),
      Card.new('5', 'Diamond'),
      Card.new('5', 'Clover'),
      Card.new('5', 'Spade'),
      Card.new('6', 'Heart'),
      Card.new('6', 'Diamond'),
      Card.new('6', 'Clover'),
      Card.new('6', 'Spade'),
      Card.new('7', 'Heart'),
      Card.new('7', 'Diamond'),
      Card.new('7', 'Clover'),
      Card.new('7', 'Spade'),
      Card.new('8', 'Heart'),
      Card.new('8', 'Diamond'),
      Card.new('8', 'Clover'),
      Card.new('8', 'Spade'),
      Card.new('9', 'Heart'),
      Card.new('9', 'Diamond'),
      Card.new('9', 'Clover'),
      Card.new('9', 'Spade'),
      Card.new('10', 'Heart'),
      Card.new('10', 'Diamond'),
      Card.new('10', 'Clover'),
      Card.new('10', 'Spade'),
      Card.new('Jack', 'Heart'),
      Card.new('Jack', 'Diamond'),
      Card.new('Jack', 'Clover'),
      Card.new('Jack', 'Spade'),
      Card.new('Queen', 'Heart'),
      Card.new('Queen', 'Diamond'),
      Card.new('Queen', 'Clover'),
      Card.new('Queen', 'Spade'),
      Card.new('King', 'Heart'),
      Card.new('King', 'Diamond'),
      Card.new('King', 'Clover'),
      Card.new('King', 'Spade')
    ]
  end
end
