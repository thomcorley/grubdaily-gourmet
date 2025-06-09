class MigrateSubscriptionMailer < ApplicationMailer
  default from: "grubdaily <grubdaily@mail.grubdaily.com>"
  default reply_to: -> { "tom@grubdaily.com" }

  def migrate(email)
    @host = ActionMailer::Base.default_url_options[:host]

    mail(to: email, subject: "Action required: update your grubdaily subscription")
    Rails.logger.info("Successfully sent `MigrateSubscription` email to #{email}")
  end
end
