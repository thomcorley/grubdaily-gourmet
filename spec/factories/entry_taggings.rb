FactoryBot.define do
  factory :entry_tagging do
    association :entry, :with_recipe
    association :tag
  end
end 