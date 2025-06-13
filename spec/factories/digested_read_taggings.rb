FactoryBot.define do
  factory :digested_read_tagging do
    association :digested_read
    association :tag
  end
end 