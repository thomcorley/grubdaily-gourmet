FactoryBot.define do
  factory :collection do
    title { "Summer Recipes Collection" }
    introduction { "A delightful collection of summer recipes perfect for warm weather cooking.\r\n\r\nThese recipes focus on fresh, seasonal ingredients and light, refreshing flavors." }
    published_at { 1.week.ago }
  end

  factory :unpublished_collection, class: Collection do
    title { "Upcoming Holiday Recipes" }
    introduction { "A collection of holiday recipes coming soon." }
    published_at { nil }
  end
end 