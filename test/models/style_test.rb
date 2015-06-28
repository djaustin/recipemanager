require 'test_helper'

class StyleTest < ActiveSupport::TestCase
	def setup 
		@style = Style.new(name: "Moroccan")
	end

	test "style is valid" do
		assert @style.valid?
	end
end
