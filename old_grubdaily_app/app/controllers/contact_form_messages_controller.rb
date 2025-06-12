class ContactFormMessagesController < ApplicationController
  def create
    @contact_form_message = ContactFormMessage.new(**formatted_params)

    unless @contact_form_message.valid?
      errors = @contact_form_message.errors.messages
      render "orders/new", locals: { errors: errors }
    else
      email = @contact_form_message.email

      ContactFormMailer.new_message(@contact_form_message).deliver

      redirect_to contact_form_confirmation_path
    end
  end

  def confirmation
  end

  private

  def confirm_email_subscription(email)
    if user_wants_to_subscribe? && !user_already_subscribed?
      subscriber = EmailSubscriber.create!(email: email)
      EmailSubscriptionConfirmationMailer.send_confirmation(email_subscriber: subscriber).deliver
    end
  end

  def user_wants_to_subscribe?
    @contact_form_message.subscribe?
  end

  def user_already_subscribed?
    EmailSubscriber.find_by_email(@contact_form_message.email).present?
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def contact_form_message_params
    params.require(:contact_form_message).permit(:name, :email, :message, :subscribe)
  end

  def formatted_params
    contact_form_message_params.to_h.deep_symbolize_keys
  end
end
