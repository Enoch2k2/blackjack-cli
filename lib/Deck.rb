class Deck
  attr_accessor :cards

  def initialize
    @cards = get_all_cards
  end

  def get_all_cards
    [
      Card.new('Ace', 'Hearts'),
      Card.new('Ace', 'Diamonds'),
      Card.new('Ace', 'Clubs'),
      Card.new('Ace', 'Spades'),
      Card.new('2', 'Hearts'),
      Card.new('2', 'Diamonds'),
      Card.new('2', 'Clubs'),
      Card.new('2', 'Spades'),
      Card.new('3', 'Hearts'),
      Card.new('3', 'Diamonds'),
      Card.new('3', 'Clubs'),
      Card.new('3', 'Spades'),
      Card.new('4', 'Hearts'),
      Card.new('4', 'Diamonds'),
      Card.new('4', 'Clubs'),
      Card.new('4', 'Spades'),
      Card.new('5', 'Hearts'),
      Card.new('5', 'Diamonds'),
      Card.new('5', 'Clubs'),
      Card.new('5', 'Spades'),
      Card.new('6', 'Hearts'),
      Card.new('6', 'Diamonds'),
      Card.new('6', 'Clubs'),
      Card.new('6', 'Spades'),
      Card.new('7', 'Hearts'),
      Card.new('7', 'Diamonds'),
      Card.new('7', 'Clubs'),
      Card.new('7', 'Spades'),
      Card.new('8', 'Hearts'),
      Card.new('8', 'Diamonds'),
      Card.new('8', 'Clubs'),
      Card.new('8', 'Spades'),
      Card.new('9', 'Hearts'),
      Card.new('9', 'Diamonds'),
      Card.new('9', 'Clubs'),
      Card.new('9', 'Spades'),
      Card.new('10', 'Hearts'),
      Card.new('10', 'Diamonds'),
      Card.new('10', 'Clubs'),
      Card.new('10', 'Spades'),
      Card.new('Jack', 'Hearts'),
      Card.new('Jack', 'Diamonds'),
      Card.new('Jack', 'Clubs'),
      Card.new('Jack', 'Spades'),
      Card.new('Queen', 'Hearts'),
      Card.new('Queen', 'Diamonds'),
      Card.new('Queen', 'Clubs'),
      Card.new('Queen', 'Spades'),
      Card.new('King', 'Hearts'),
      Card.new('King', 'Diamonds'),
      Card.new('King', 'Clubs'),
      Card.new('King', 'Spades')
    ]
  end
end
