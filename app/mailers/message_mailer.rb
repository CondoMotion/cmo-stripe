class MessageMailer < ActionMailer::Base
  def contact_us(message)
  	@message = message
    mail(:to => "info@condomotion.com", :subject => message.subject, from: message.email)
  end
end