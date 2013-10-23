require "test/unit"
require "rack/test"
require "./lib/rps.rb"

class RpsTest < Test::Unit::TestCase
#	include Rack::Test::Methods
	
	def setup
		@nav = Rack::Test::Session.new(Rack::MockSession.new(Rsack::Server.new(Rack::Session::Cookie.new(RockPaperScissors::App.new, :key => 'rack.session', :domain => 'prueba.com', :secret => 'some_secret'))))
	end
	
	def app
		Rack::Builder.new do
			run @nav
		end
			#run RockPaperScissors::App.new
		#end.to_app
	end

	#############Añadir test
	
	def computer
		computer_throw = 'rock'
	end

	def test_index
		@nav.get "/"
		#pust last_response.inspect
		assert @nav.last_response.ok?
	end

	def test_tie
		@nav.get"/?choice='rock'"
		assert @nav.last_response.body.include?("Result: You tied with the computer")
	end

	def test_h2
		@nav.get "/"
		assert_match "<h2> Choose a throw: </h2>", @nav.last_response.body
	end
end
