FactoryBot.define do
  factory :collection_entry do
    association :collection
    association :entry, :with_recipe
  end
end 