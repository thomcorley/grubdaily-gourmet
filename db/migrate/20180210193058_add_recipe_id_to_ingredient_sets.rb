class AddRecipeIdToIngredientSets < ActiveRecord::Migration[5.1]
  def change
    add_column :ingredient_sets, :recipe_id, :integer
  end
end
