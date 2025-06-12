FactoryBot.define do
  factory :method_step, class: MethodStep do
    position { 1 }
    description { "Peel and finely chop the onions" }
    recipe
  end
end
