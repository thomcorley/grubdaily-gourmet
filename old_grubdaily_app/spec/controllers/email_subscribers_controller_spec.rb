require "rails_helper"

RSpec.describe EmailSubscribersController do
  let(:api_client) { double('EmailMarketingApiClient', create_contact: nil) }
  let(:logger) { double("Logger", info: nil, error: nil) }

  describe "POST #create" do
    let(:new_subscriber_request) { post :create, params: { email: "email@example.com"} }
    before { allow(controller).to receive(:email_marketing_api_client).and_return(api_client) }

    it "invokes EmailMarketingApiClient to create a member" do
      expect(api_client).to receive(:create_contact)
      new_subscriber_request
    end

    it "logs a message" do
      allow(controller).to receive(:logger).and_return(logger)
      expect(logger).to receive(:info).with(/New email subscriber signed up/)
      new_subscriber_request
    end
  end
end
