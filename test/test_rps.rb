require "test/unit"
require "rack/test"
require "../lib/rps.rb"

class RpsTest < Test::Unit::TestCase
	include Rack::Test::Methods

	def app
		Rack::Builder.new do
			run RockPaperScissors::App.new
		end.to_app
	end

	#############Añadir test

	def test_index
		get "/"
		#pust last_response.inspect
		assert last_response.ok?
	end
end
