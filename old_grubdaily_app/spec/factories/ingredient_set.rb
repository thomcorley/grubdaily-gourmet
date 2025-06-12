FactoryBot.define do
  factory :ingredient_set, class: IngredientSet do
    title { "For the sauce" }
    position { 1 }
    recipe

    after(:create) do |ingredient_set, _evaluator|
      create_list(:ingredient_entry, 10, ingredient_set: ingredient_set)
    end
  end
end
