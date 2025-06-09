class AddMarkedForPromotionAtToRecipes < ActiveRecord::Migration[7.0]
  def change
    add_column :recipes, :marked_for_promotion_at, :datetime
  end
end
