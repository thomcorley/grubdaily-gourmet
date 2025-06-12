module Nutrition
  class ApiNinjasApiFormat
    def self.keys_mapping
      {
        calories: :calories,
        fat_total_g: :total_fat,
        fat_saturated_g: :saturated_fat,
        protein_g: :protein,
        sodium_mg: :sodium,
        potassium_mg: :potassium,
        cholesterol_mg: :cholesterol,
        carbohydrates_total_g: :carbohydrates,
        sugar_g: :sugar,
        fiber_g: :fibre,
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

    def self.standardise_format(hsh)
      hsh = hsh.deep_symbolize_keys

      hsh.select_keys(*keys_mapping.keys).each_with_object({}) do |nutrient, hash|
        key = keys_mapping[nutrient[0]]
        value = nutrient[1]

        hash[key] = {
          amount: value,
          unit: units_mapping[key]
        }
      end
    end
  end
end
