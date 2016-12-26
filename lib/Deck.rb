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
      Card.new('2', 'Hearts', 2),
      Card.new('2', 'Diamonds', 2),
      Card.new('2', 'Clubs', 2),
      Card.new('2', 'Spades', 2),
      Card.new('3', 'Hearts', 3),
      Card.new('3', 'Diamonds', 3),
      Card.new('3', 'Clubs', 3),
      Card.new('3', 'Spades', 3),
      Card.new('4', 'Hearts', 4),
      Card.new('4', 'Diamonds', 4),
      Card.new('4', 'Clubs', 4),
      Card.new('4', 'Spades', 4),
      Card.new('5', 'Hearts', 5),
      Card.new('5', 'Diamonds', 5),
      Card.new('5', 'Clubs', 5),
      Card.new('5', 'Spades', 5),
      Card.new('6', 'Hearts', 6),
      Card.new('6', 'Diamonds', 6),
      Card.new('6', 'Clubs', 6),
      Card.new('6', 'Spades', 6),
      Card.new('7', 'Hearts', 7),
      Card.new('7', 'Diamonds', 7),
      Card.new('7', 'Clubs', 7),
      Card.new('7', 'Spades', 7),
      Card.new('8', 'Hearts', 8),
      Card.new('8', 'Diamonds', 8),
      Card.new('8', 'Clubs', 8),
      Card.new('8', 'Spades', 8),
      Card.new('9', 'Hearts', 9),
      Card.new('9', 'Diamonds', 9),
      Card.new('9', 'Clubs', 9),
      Card.new('9', 'Spades', 9),
      Card.new('10', 'Hearts', 10),
      Card.new('10', 'Diamonds', 10),
      Card.new('10', 'Clubs', 10),
      Card.new('10', 'Spades', 10),
      Card.new('Jack', 'Hearts', 10),
      Card.new('Jack', 'Diamonds', 10),
      Card.new('Jack', 'Clubs', 10),
      Card.new('Jack', 'Spades', 10),
      Card.new('Queen', 'Hearts', 10),
      Card.new('Queen', 'Diamonds', 10),
      Card.new('Queen', 'Clubs', 10),
      Card.new('Queen', 'Spades', 10),
      Card.new('King', 'Hearts', 10),
      Card.new('King', 'Diamonds', 10),
      Card.new('King', 'Clubs', 10),
      Card.new('King', 'Spades', 10)
    ]
  end
end
