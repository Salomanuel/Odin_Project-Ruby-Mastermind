class Blog
	def title
		"Treehouse Blog"
	end
end

require "minitest/autorun"
require "minitest/pride"

class TestBlog < Minitest::Test
	def setup
		@blog = Blog.new
	end

	def test_title_is_treehouse
		assert_equal "Treehouse Blog", @blog.title
	end
end