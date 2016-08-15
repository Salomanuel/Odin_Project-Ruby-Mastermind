module Board
	def board_show
		@board = []
		10.times do 
			@board << [" ",".",".",".","."].join(" ")
		end
		@board[turn_number][0] = ">"
		return @board
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
	end
end

module Code
	def code
		range = (?A..?F).to_a
		@code = []
		4.times { @code << range[rand(6)] }
		return @code
	end
end

class MasterMind
	include Turn
	include Board
	include Code

	attr_accessor :name, :board
	def initialize
		@name = "culo"
		puts board_show
		code
	end

end


MasterMind.new