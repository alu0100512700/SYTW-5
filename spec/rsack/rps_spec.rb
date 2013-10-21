require 'spec_helper'

describe RockPaperScissors::App do

	#let(:server) { Rack::MockRequest.new(RockPaperScissors::App.new) }
	def server
		Rack::MockRequest.new(RockPaperScissors::App.new)
	end

	context '/' do
		it "should return a 200 code" do
			response = server.get('/')
			response.status.should == 200
		end
	end
end
