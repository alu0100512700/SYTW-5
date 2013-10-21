require './lib/rsack'

use Rack::Static, :urls => ["/public"]
run RockPaperScissors::App.new

