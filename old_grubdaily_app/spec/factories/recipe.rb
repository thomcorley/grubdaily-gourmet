FactoryBot.define do
  factory :recipe, class: Recipe do
    title { "Berber Omelette" }
    introduction { "An old French classic, this is truly an old school soup. It is rich and dark with beef stock and, if made correctly, should be very thick." }
    summary { "This is a rich and hearty soup from the classic French repertoire. It's one of my favourites." }
    total_time { "PT6H" }
    serves { 2 }
    makes { nil }
    recipe_type { "soup" }
    image_url { nil }
    tags { "these, are, test, tags" }
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
end
