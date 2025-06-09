class AddNutritionToRecipes < ActiveRecord::Migration[7.0]
  def change
    add_column :recipes, :nutrition, :json
    add_column :recipes, :show_nutrition, :boolean
  end
end
