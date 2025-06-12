# Preview all emails at http://localhost:2020/rails/mailers/recipe_mailer
class EmailSubscriptionConfirmationMailerPreview < ActionMailer::Preview
  def send_confirmation
    email_subscriber = EmailSubscriber.new(email: "mail@example.com")
    EmailSubscriptionConfirmationMailer.send_confirmation(email_subscriber: email_subscriber)
  end
end
