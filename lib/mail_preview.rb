class MailPreview < MailView
  def welcome
    post = Post.last
    mail = PostMailer.new_post(post, "earlynovrock@gmail.com")
    mail
  end
end