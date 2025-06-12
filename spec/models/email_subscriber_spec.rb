require "rails_helper"

RSpec.describe EmailSubscriber do
  context "creation" do
    it "validates email" do
      subscriber = EmailSubscriber.new(email: "notanemail.com")
      expect(subscriber).not_to be_valid
    end
  end
end
