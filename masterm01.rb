module Board
	def board_show
		@board.each { |row| puts row.join(" ") }
	end
		
	def board_init
		@board ||= []
		10.times do 
			@board << [" ",".",".",".",".","",""]#.join(" ")
		end
	end

	def board_print_turn
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
		@turn ||= 0
		@turn +=  1
		loose if @turn >= 10
		turn
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
		return @code
	end
end

module Input
	def input
		@guess = gets.chomp.upcase.split("")
	end
end

module Analyzer
	def dots_giver
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
		@board[turn_number][5] = "w:#{@white_dot}"
		@board[turn_number][6] = "b:#{@black_dot}"
	end

	def win
		puts "that was the right combination, good job"
		exit
	end
end

class MasterMind
	include Board
	include Code
	include Input
	include Analyzer
	include Turn

	def initialize
		board_init
		code 									#initializes secret code
		#puts "code: #{@code}" 		#will be deleted									
		puts "guess the four-character code with the letters A B C D E F"
		turn
	end

end


MasterMind.new