class PostMailer < ActionMailer::Base
  default from: "from@example.com"

  def new_post(post)
    @post = post
    mail(
      :to => "earlynovrock@gmail.com", 
      :bcc => post.visible_to,
      :subject => "New Post"
    )
  end
end
