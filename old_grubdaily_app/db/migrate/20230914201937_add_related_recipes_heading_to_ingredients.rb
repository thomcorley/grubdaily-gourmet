class AddRelatedRecipesHeadingToIngredients < ActiveRecord::Migration[7.0]
  def change
    add_column :ingredients, :related_recipes_heading, :string
  end
end
