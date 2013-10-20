require './lib/rps'

use Rack::Static, :urls => ["/public"]
run RockPaperScissors::App.new

