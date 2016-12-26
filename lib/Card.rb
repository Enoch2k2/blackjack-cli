class Card
  attr_accessor :name, :type, :value

  def initialize(name, type, value=nil)
    @name = name
    @type = type
    @value = value
  end

end
