FactoryBot.define do
  factory :ingredient_entry, class: IngredientEntry do
    quantity { 10 }
    unit { "g" }
    size { nil }
    modifier { "finely chopped" }
    ingredient_name { "carrot" }
    original_string { "10 g carrot, finely chopped" }
    ingredient_set
  end
end
