module Nutrition
  class NutritionixApiFormat
    def self.keys_mapping
      {
        nf_calories: :calories,
        nf_total_fat: :total_fat,
        nf_saturated_fat: :saturated_fat,
        nf_protein: :protein,
        nf_sodium: :sodium,
        nf_potassium: :potassium,
        nf_cholesterol: :cholesterol,
        nf_total_carbohydrate: :carbohydrates,
        nf_sugars: :sugar,
        nf_dietary_fiber: :fibre,
      }
    end

    def self.units_mapping
      {
        calories: nil,
        total_fat: 'g',
        saturated_fat: 'g',
        protein: 'g',
        sodium: 'mg',
        potassium: 'mg',
        cholesterol: 'mg',
        carbohydrates: 'g',
        sugar: 'g',
        fibre: 'g'
      }
    end

    def self.standardise_format(response)
      response.parsed_response['foods'].each_with_object(Hash.new { |hash, key| hash[key] = { amount: 0, unit: units_mapping[key] } }) do |food, result|
        food.deep_symbolize_keys.select_keys(*keys_mapping.keys).each do |key, value|
          next unless (key && value)

          mapped_key = keys_mapping[key]
          result[mapped_key][:amount] += value
        end
      end
    end
  end
end
