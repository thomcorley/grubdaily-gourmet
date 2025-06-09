class EmailSubscribersController < ApplicationController
  def create
    email = params[:email]
    create_email_marketing_contact

    log_info("New email subscriber signed up and deferred to marketing system")
    redirect_to send_confirmation_email_subscribers_path
  rescue ActiveRecord::RecordInvalid => e
    log_error("Could not save email subscription: #{e.message}")

    redirect_to root_url
  end

  def send_confirmation
    # The confirmation email is sent by mailchimp upon creation of a `pending` member
  end

  def subscription_confirmed
    entries = (Recipe.published_with_image.first(3) + BlogPost.published.first(3))
    @entries_for_display = entries.sort_by{ |entry| entry.created_at }.reverse
    @recent_entries = @entries_for_display.first(4)
  end

  private

  def email_subscriber_params
    params.require(:email_subscriber).permit(:email, :id)
  end

  def create_email_marketing_contact
    email_marketing_api_client.create_contact(email: params["email"])
  end

  def email_marketing_api_client
    @email_marketing_api_client ||= EmailMarketingApiClient.new
  end
end
