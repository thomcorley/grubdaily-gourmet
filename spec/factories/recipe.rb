FactoryBot.define do
  factory :recipe_without_entry, class: Recipe do
    title { "Berber Omelette" }
    total_time { "PT6H" }
    serves { 2 }
    makes { nil }
    recipe_type { "soup" }
    image_url { nil }
    published_at { Time.now }
    marked_for_promotion_at { Time.now }

    after(:build) do |recipe|
      recipe.image.attach({
        io: File.open(Rails.root.join("app", "assets", "images", "berber-omelette.jpg")),
        filename: "berber-omelette.jpg",
        content_type: "image/jpeg",
      })
    end

    after(:create) do |recipe, _evaluator|
      create_list(:ingredient_set, 1, recipe: recipe)
      create_list(:method_step, 5, recipe: recipe)
    end
  end

  factory :recipe, class: Recipe do
    title { "Berber Omelette" }
    total_time { "PT6H" }
    serves { 2 }
    makes { nil }
    recipe_type { "soup" }
    image_url { nil }
    published_at { Time.now }
    marked_for_promotion_at { Time.now }

    after(:build) do |recipe|
      recipe.image.attach({
        io: File.open(Rails.root.join("app", "assets", "images", "berber-omelette.jpg")),
        filename: "berber-omelette.jpg",
        content_type: "image/jpeg",
      })

      # Create the associated entry
      entry = build(:entry,
        title: recipe.title,
        summary: "This is a rich and hearty soup from the classic French repertoire. It's one of my favourites.",
        content: "An old French classic, this is truly an old school soup. It is rich and dark with beef stock and, if made correctly, should be very thick.",
        published_at: recipe.published_at,
        marked_for_promotion_at: recipe.marked_for_promotion_at
      )
      entry.entryable = recipe
      recipe.entry = entry
    end

    after(:create) do |recipe, _evaluator|
      recipe.entry.save! if recipe.entry
      
      # Set up default tags
      recipe.tags = ["soup", "french", "classic"]
      
      create_list(:ingredient_set, 1, recipe: recipe)
      create_list(:method_step, 5, recipe: recipe)
    end
  end
end
