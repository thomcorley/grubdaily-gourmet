class AddRelatedRecipeIdsToRecipes < ActiveRecord::Migration[7.0]
  def change
    add_column :recipes, :related_recipe_ids, :text, array: true, default: []
    add_column :recipes, :related_recipes_heading, :string
  end
end
