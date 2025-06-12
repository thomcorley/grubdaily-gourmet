FactoryBot.define do
  factory :ingredient do
    name { "carrot" }
    synonyms { "carrots" }
    content { "Lorem Ipsum is simply dummy text of the printing and typesetting industry." }
    animal_status { 'vegan' }
    nutrition { "" }
    publishable { true }
  end
end
