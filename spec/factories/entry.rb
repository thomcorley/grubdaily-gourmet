FactoryBot.define do
  factory :entry do
    title { "Sample Entry" }
    summary { "A sample entry summary" }
    content { "This is sample content for the entry." }
    published_at { Time.now }
    marked_for_promotion_at { nil }
    has_image { false }

    trait :with_recipe do
      association :entryable, factory: :recipe_without_entry
    end

    trait :with_blog_post do
      association :entryable, factory: :blog_post_without_entry
    end

    trait :published do
      published_at { Time.now }
    end

    trait :unpublished do
      published_at { nil }
    end
  end
end 