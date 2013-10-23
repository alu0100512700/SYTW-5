require 'spec_helper'

describe Rsack::Server do

	#let(:server) { Rack::MockRequest.new(RockPaperScissors::App.new) }
	def server
		Rack::MockRequest.new(Rsack::Server.new)
	end

	context '/' do
		it "should return a 200 code" do
			response = server.get('/')
			response.status.should == 200
		end
	end

	context "/?choice='rock'" do
		it "should return a 200 code" do
			response = server.get("/?choice='scissors'")
			response.status.should == 200
		end

	end
end
