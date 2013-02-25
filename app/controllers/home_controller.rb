class HomeController < ApplicationController
	
	def index
	end

	def featured_sites
	end

	def contact
		@message = Message.new
	end

end