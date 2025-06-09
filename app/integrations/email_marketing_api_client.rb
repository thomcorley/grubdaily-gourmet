# frozen_string_literal: true
class EmailMarketingApiClient
  include Logging
  attr_reader :client

  GRUBDAILY_MAILCHIMP_LIST_ID = "291fd6ddcf"

  def initialize
    @client = MailchimpMarketing::Client.new

    client.set_config({
      api_key: Rails.application.credentials.dig(:mailchimp, :api_key),
      server: Rails.application.credentials.dig(:mailchimp, :api_server),
    })
  end

  def create_contact(email:)
    client.lists.add_list_member(
      GRUBDAILY_MAILCHIMP_LIST_ID,
      {
        email_address: email,
        status: "pending"
      }
    )

    log_info("Successfully created member in Mailchimp list")
  rescue StandardError => e
    log_error("Could not add member to Mailchimp list: #{e}")
  end
end
