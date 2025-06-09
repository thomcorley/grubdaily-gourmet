module Nutrition
  DAILY_VALUES = {
    calories: {
      amount: 2500,
      unit:   nil
    },
    total_fat: {
      amount: 97,
      unit: 'g'
    },
    saturated_fat: {
      amount: 31,
      unit: 'g'
    },
    protein: {
      amount: 80,
      unit: 'g'
    },
    cholesterol: {
      amount: 300,
      unit: 'mg'
    },
    carbohydrates: {
      amount: 333,
      unit: 'g'
    },
    sugar: {
      amount: 33,
      unit: 'g'
    },
    salt: {
      amount: 6,
      unit: 'g'
    },
    vitamin_a: {
      amount: 700,
      unit: 'ug'
    },
    thiamin: {
      amount: 1,
      unit: 'mg'
    },
    riboflavin: {
      amount: 1.3,
      unit: 'mg'
    },
    niacin: {
      amount: 16.5,
      unit: 'mg'
    },
    vitamin_b6: {
      amount: 1.4,
      unit: 'mg'
    },
    vitamin_b12: {
      amount: 1.5,
      unit: 'ug'
    },
    folate: {
      amount: 200,
      unit: 'ug'
    },
    vitamin_c: {
      amount: 40,
      unit: 'g'
    },
    vitamin_d: {
      amount: 10,
      unit: 'ug'
    },
    iron: {
      amount: 8.7,
      unit: 'mg'
    },
    calcium: {
      amount: 700,
      unit: 'mg'
    },
    magnesium: {
      amount: 300,
      unit: 'mg'
    },
    potassium: {
      amount: 3500,
      unit: 'mg'
    },
    zinc: {
      amount: 9.5,
      unit: 'mg'
    },
    copper: {
      amount: 1.2,
      unit: 'mg'
    },
    iodine: {
      amount: 140,
      unit: 'ug'
    },
    selenium: {
      amount: 75,
      unit: 'ug'
    },
    phosphorus: {
      amount: 550,
      unit: 'mg'
    },
    chloride: {
      amount: 2500,
      unit: 'mg'
    },
    sodium: {
      amount: 2400,
      unit: 'mg'
    },
    fibre: {
      amount: 30,
      unit: 'g'
    }
  }

  def daily_values
    DAILY_VALUES
  end

  module_function :daily_values
end
