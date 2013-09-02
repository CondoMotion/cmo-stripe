class HomeController < ApplicationController
	
	def index
	end

  def about
  end

	def featured_sites
	end

	def contact
		@message = Message.new
	end

  def tabs
    @message = "I'm tab 1"
  end

  def tab1
    @message = "I'm tab 1"
    
    respond_to do |format|
      format.js
    end
  end

  def tab2
    @message = "I'm tab 2"
    
    respond_to do |format|
      format.js
    end
  end

  def tab3
    @message = "I'm tab 3"
    
    respond_to do |format|
      format.js
    end
  end

end