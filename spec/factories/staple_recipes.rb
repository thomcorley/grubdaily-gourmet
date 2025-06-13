FactoryBot.define do
  factory :staple_recipe do
    sequence(:title) { |n| "Basic Bread Dough #{n}" }
    total_time { "PT3H30M" }
    serves { 8 }
    recipe_type { "staple" }
    category { "basics" }
    published_at { 1.week.ago }

    after(:build) do |staple_recipe|
      # Create the associated entry
      entry = build(:entry,
        title: staple_recipe.title,
        summary: "A fundamental bread dough recipe that serves as the base for many baked goods",
        content: "This basic bread dough is versatile and can be used for various bread types. Perfect for beginners learning to bake.",
        published_at: staple_recipe.published_at
      )
      entry.entryable = staple_recipe
      staple_recipe.entry = entry
    end

    after(:create) do |staple_recipe, _evaluator|
      if staple_recipe.entry
        staple_recipe.entry.save!
        
        # Set up default tags using delegation, like the regular recipe factory
        staple_recipe.tags = ["staple", "bread", "basics"]
      end
    end
  end

  factory :staple_recipe_without_entry, class: StapleRecipe do
    sequence(:title) { |n| "Basic Bread Dough #{n}" }
    total_time { "PT3H30M" }
    serves { 8 }
    recipe_type { "staple" }
    category { "basics" }
    published_at { 1.week.ago }
  end
end 