module Board
	def board_show
		#puts "board_show is go"
		@board.each { |row| puts row.join(" ") }
	end
		
	def board_init
		@board ||= []
		10.times do 
			@board << [" ",".",".",".",".","",""]#.join(" ")
		end
	end

	def board_print_turn
		#puts "this is board_print_turn"
		@board[turn_number][0] = ">"
		4.times { |j|	@board[turn_number][j+1] = @guess[j] }
	end
end

module Turn
	def turn_number
		@turn ||= 0
		return @turn
	end

	def turn_next	
		#puts "turn_next is go; @human is #{@human}"
		@turn ||= 0
		@turn +=  1
		loose if @turn >= 10
		
		case @human
		when true  then turn
		when false then ai_turn
		end
	end

	def turn
		input 						#takes the player input
		board_print_turn	#writes the move into the board
		dots_giver				#calculates black and white dots
		turn_score				#writes the white and black dots into the board
		board_show				#prints the board
		turn_next					#calls a new turn
	end

	def loose
		puts "maximum turns elapsed, you lost"
		puts "the code was: #{@code.join(" ")}"
		exit
	end
end

module Code
	def code
		range = (?A..?F).to_a
		@code = []
		4.times { @code << range[rand(6)] }
		#@code = %w(P V V V)			#cheating for testing
		@code =  %w(A B E F)
		return @code
	end
end

module Input
	def input
		case @human
		when true 	
			puts "guess the four-character code with the letters A B C D E F" if @turn == 0
			@guess = gets.chomp.upcase.split("")			
		when false	then ai_turn
		end
	end
end

module Analyzer
	def dots_giver
		#puts "this is dots_giver"
		codepop = @code
		guesson = @guess
		#puts "guess: #{@guess.join} codepop:#{codepop.join}"
		#puts "code: #{@code}"
		@white_dot = 0
		@black_dot = 0

		@guess.each_index do |j|
			if codepop[j] == @guess[j]
				@black_dot += 1
			elsif codepop.include?(guesson[j])
				#puts "#{codepop} include #{guesson[j]}? #{codepop.include?(guesson[j])}"
				@white_dot += 1
				guesson[j] = ""
			end
		end
		win if @black_dot >= 4
	end

	def turn_score
		#puts "this is turn score"
		@board[turn_number][5] = "w:#{@white_dot}"
		@board[turn_number][6] = "b:#{@black_dot}"
	end

	def win
		puts "that was the right combination, good job"
		exit
	end
end

module AI
	def ai_turn
		puts "this is ai_turn"
		five_guess				#AI move
		board_print_turn	#writes the move into the board
		dots_giver				#calculates black and white dots
		turn_score				#writes the white and black dots into the board
		board_show				#prints the board
		turn_next					#calls a new turn
	end

	def five_guess
		puts "\n\nturn #{@turn+1}"
		if 		@turn == 0
			puts "initializing five-guess-AI"
			@guess = %w[A A A A]
		elsif 
			range = (?A..?F).to_a
			@guess = []
			4.times { @guess << range[rand(6)] }
		end
	end
end

class MasterMind			#BANANA VARIABLE TO ALWAYS USE AI
	include Board
	include Code
	include Input
	include Analyzer
	include Turn
	include AI

	def initialize
		turn_number						#initializes the turn count
		board_init						#initializes the board
		code 									#initializes secret code
		#puts "code: #{@code}" 		#will be deleted									
		choose_game
	end

	def choose_game
		puts "do you want the computer to play?"
		#case gets.chomp
		bANANA = "yes"
		case bANANA
		when "yes"	
			@human = false
			ai_turn
		when "no" 	
			@human = true
			turn
		else 
			puts "don't be a moron and choose properly"
			choose_game
		end
	end

end


MasterMind.new