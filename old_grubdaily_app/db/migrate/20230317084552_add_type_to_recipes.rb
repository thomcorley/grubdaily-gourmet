class AddTypeToRecipes < ActiveRecord::Migration[7.0]
  def change
    add_column :recipes, :type, :string
  end
end
