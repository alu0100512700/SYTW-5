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
			response = server.get("/?choice='rock'")
			response.status.should == 200
		end

		it "should tie" do
			computer_throw = 'rock'
			response = server.get("/?choice='rock'")
			response.body.include?("Result: You tied with the computer")
		end

		it "should win" do
			computer_throw = 'scissors'
			response = server.get("/?choice='rock'")
			response.body.include?("Result: Nicely done; rock beats scissors")
		end

		it "should lose" do
			computer_throw = 'paper'
			response = server.get("/?choice='rock'")
			response.body.incluse?("Result: Ouch; paper beats rock. Better luck next time!")
		end
	end

	context "/?choice='paper'" do
		it "should return a 200 code" do
			response = server.get("/?choice='paper'")
			response.status.should == 200
		end

		it "should tie" do
			computer_throw = 'paper'
			response = server.get("/?choice='paper'")
			response.body.include?("Result: You tied with the computer")
		end

		it "should win" do
			computer_throw = 'rock'
			response = server.get("/?choice='paper'")
			response.body.include?("Result: Nicely done; paper beats rock")
		end
	end

	context "/?choice='scissors'" do
		it "should return a 200 code" do
			response = server.get("/?choice='scissors'")
			response.status.should == 200
		end

		it "should tie" do
			computer_throw = 'scissors'
			response = server.get("/?choice='scissors'")
			response.body.include?("Result: Your tied with the computer")
		end
	end
end
