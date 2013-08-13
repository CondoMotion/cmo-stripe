class PostMailer < ActionMailer::Base
  default from: "info@condomotion.com"

  def new_post(post)
    @post = post
    attachments.inline['logo.png'] = File.read("#{Rails.root}/app/assets/images/logo.png")
    mail(
      :from => @post.user.email,
      :to => "earlynovrock@gmail.com", 
      :reply_to => post.manager_emails,
      :bcc => post.visible_to_emails,
      :subject => "New post by #{@post.company.name} on Condo Motion"
    )
  end
end
