require 'rack/request'
require 'rack/response'
require 'haml'
require 'rack'

module RockPaperScissors
    class App 
  
      def initialize(app = nil)
        @app = app
        @content_type = :html
        @defeat = {'rock' => 'scissors', 'paper' => 'rock', 'scissors' => 'paper'}
        @throws = @defeat.keys
        @choose = @throws.map { |x| 
           %Q{ <li><a href="/?choice=#{x}">#{x}</a></li> }     #Puedes meter en haml con %li
        }.join("\n")
        @choose = "<p>\n<ul>\n#{@choose}\n</ul>\n</p>"				#Puedes añadir en haml con %p 
      end

			def set_env(env)
				@env = env
				@session = env['rack.session']
			end

			def win
				return @session['won'].to_i if @session['won']
				@session['won'] = 0
			end

			def win=(value)
				@session['won'] = value
			end

			def lose
				return @session['lost'].to_i if @session['lost']
				@session['lost'] = 0
			end

			def lose=(value)
				@session['lost'] = value
			end

			def tie
				return @session['tied'].to_i if @session['tied']
				@session['tied'] = 0
			end

			def tie=(value)
				@session['tied'] = value
			end

			def play
				return @session['play'].to_i if @session['play']
				@session['play'] = 0
			end

			def play=(value)
				@session['play'] = value
			end

      def call(env)

				set_env(env)
        req = Rack::Request.new(env)
  
        req.env.keys.sort.each { |x| puts "#{x} => #{req.env[x]}" }
  
        computer_throw = @throws.sample
        player_throw = req.GET["choice"]
        answer = if !@throws.include?(player_throw)
            ""
          elsif player_throw == computer_throw
						
						self.play=self.play+1
						self.tie=self.tie+1
            "Result: You tied with the computer"
						
          elsif computer_throw == @defeat[player_throw]
            
						self.play=self.play+1
						self.win=self.win+1
						"Result: Nicely done; #{player_throw} beats #{computer_throw}"
						
          else
						
						self.play=self.play+1
						self.lose=self.lose+1
            "Result: Ouch; #{computer_throw} beats #{player_throw}. Better luck next time!"
						
          end

        engine = Haml::Engine.new File.open("views/index.haml").read  
        res = Rack::Response.new

        res.write engine.render({},
          :answer => answer,
          :choose => @choose,
					:win => self.win,
					:lose => self.lose,
					:tie => self.tie,
					:play => self.play,
          #:throws => @throws
          #:computer_throw => computer_throw,
          #:player_throw => player_throw,
          #:aux => aux
        )
        res.finish 
      end # call
    end   # App
  end     # RockPaperScissors

#  if $0 == __FILE__
#    require 'rack/showexceptions'
#    Rack::Server.start(
#      :app => Rack::ShowExceptions.new(
#                Rack::Lint.new(
#                  RockPaperScissors::App.new)),
#      :Port => 9292,
#      :server => 'thin'
#    )
#  end
