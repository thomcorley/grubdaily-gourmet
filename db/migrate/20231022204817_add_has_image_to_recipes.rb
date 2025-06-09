class AddHasImageToRecipes < ActiveRecord::Migration[7.0]
  def change
    add_column :recipes, :has_image, :boolean
  end
end
