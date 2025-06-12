# Preview all emails at http://localhost:2020/rails/mailers/blog_post_mailer
class BlogPostMailerPreview < ActionMailer::Preview
  def new_blog_post
    email_subscriber = EmailSubscriber.find_or_create_by(email: "mail@example.com")
    BlogPostMailer.new_blog_post(blog_post: BlogPost.all.sample, email_subscriber: email_subscriber)
  end
end
