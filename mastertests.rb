require          'minitest/autorun'
require          'minitest/pride'
require_relative 'masterm01'

class MasterTest < Minitest::Test

	describe "#Board" do
		it "has_ten_rows" do
			assert_equal 10, MasterMind.new.board.length
		end
	end
end