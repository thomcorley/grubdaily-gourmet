class ContactFormMailer < ApplicationMailer
  default from: "grubdaily <grubdaily@mail.grubdaily.com>"
  default reply_to: -> { @contact_form_message.email }

  def new_message(contact_form_message)
    @contact_form_message = contact_form_message
    @host = ActionMailer::Base.default_url_options[:host]
    email = @contact_form_message.email

    mail(to: to_address, subject: "New contact form message from #{email}")
    Rails.logger.info("Successfully sent a new contact form message")
  end

  private

  def to_address
    if Rails.env.production?
      ADMIN_EMAIL_ADDRESS
    else
      ADMIN_EMAIL_ADDRESS_DEV
    end
  end
end
