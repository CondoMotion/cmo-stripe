class MessagesController < ApplicationController
  def create
    @message = Message.new(params[:message])
    if @message.valid?
      MessageMailer.contact_us(@message).deliver
      redirect_to '/contact', notice: "Message sent! Thank you for contacting us."
    else
      render "home/contact"
    end
  end
end