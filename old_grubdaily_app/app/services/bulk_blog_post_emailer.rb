class BulkBlogPostEmailer
  def self.deliver_email_update(blog_post)
    EmailSubscriber.confirmed.each do |email_subscriber|
      next if BlogPostMailer::TEST_EMAILS.include?(email_subscriber.email)
      BlogPostMailer.new_blog_post(blog_post: blog_post, email_subscriber: email_subscriber).deliver
    end
  end
end
