# frozen_string_literal: true
require "rails_helper"

RSpec.describe EmailMarketingApiClient do
  # Stub the MailchimpMarketing constant
  let(:mailchimp_client_class) { double("MailchimpMarketing::Client") }
  let(:mailchimp_client) { double("client_instance") }
  
  before do
    stub_const("MailchimpMarketing::Client", mailchimp_client_class)
    allow(mailchimp_client_class).to receive(:new).and_return(mailchimp_client)
    allow(mailchimp_client).to receive(:set_config)
    allow(mailchimp_client).to receive(:lists).and_return(lists_api)
  end

  let(:api_client) { described_class.new }
  let(:list_id) { described_class::GRUBDAILY_MAILCHIMP_LIST_ID }
  let(:lists_api) { instance_double("ListApi", add_list_member: true, update_list_member: true)}
  let(:email) { "email@example.com" }

  describe "#create_contact" do
    let(:create_contact) { api_client.create_contact(email: email) }

    it "calls the mailchimp client" do
      expect(mailchimp_client).to receive(:lists)
      create_contact
    end

    it "logs a message" do
      allow(mailchimp_client).to receive(:lists).and_return(lists_api)
      expect(Rails.logger).to receive(:info).with(/Successfully created member/)
      create_contact
    end

    it "when encountering an error it logs a message" do
      allow(mailchimp_client).to receive(:lists).and_raise("Boom!")
      expect(Rails.logger).to receive(:error).with(/Boom!/)
      create_contact
    end

    it "invokes the mailchimp client to create a member" do
      expected_params = { email_address: email, status: "pending" }
      expect(lists_api).to receive(:add_list_member).with(list_id, expected_params)
      create_contact
    end
  end
end
