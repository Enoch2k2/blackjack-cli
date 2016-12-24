Gem::Specification.new do |s|
  s.name = 'blackjack-cli'
  s.version = '0.0.2'
  s.date = '2016-12-24'
  s.summary = 'Blackjack'
  s.description = 'A simple Blackjack Cli Game'
  s.authors = ["Enoch Griffith"]
  s.email = ["enoch2k2@hotmail.com"]
  s.files = ["bin/blackjack", "config/environment.rb", "lib/Card.rb", "lib/Cli.rb", "lib/Deck.rb", "lib/Game.rb", "lib/Player.rb", "lib/players/Computer.rb", "lib/players/Human.rb", "README.md"]
  s.license = "MIT"
  s.homepage =
    'http://rubygems.org/gems/enoch2k2-blackjack-cli'
  s.executables << 'blackjack'
end
