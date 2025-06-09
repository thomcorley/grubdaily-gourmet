class AddPublishedAtToRecipes < ActiveRecord::Migration[6.0]
  def change
    add_column :recipes, :published_at, :datetime
  end
end
