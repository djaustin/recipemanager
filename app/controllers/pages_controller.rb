class PagesController < ApplicationController
	def home
		redirect_to recipes_path if current_user
	end
end
