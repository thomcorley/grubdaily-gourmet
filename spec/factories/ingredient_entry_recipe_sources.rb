FactoryBot.define do
  factory :ingredient_entry_recipe_source do
    association :ingredient_entry
    association :recipe, factory: :recipe_without_entry
  end
end 