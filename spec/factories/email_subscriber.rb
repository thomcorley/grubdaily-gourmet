FactoryBot.define do
  factory :email_subscriber, class: EmailSubscriber do
    email { "email@example.com" }
    confirmed { false }
  end
end
