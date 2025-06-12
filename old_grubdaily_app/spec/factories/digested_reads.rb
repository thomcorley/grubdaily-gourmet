FactoryBot.define do
  factory :digested_read do
    title { "MyString" }
    summary { "MyString" }
    content { "MyText" }
    excerpt { "MyText" }
    tags { "MyString" }
    published_at { Date.today.beginning_of_day }
  end
end
