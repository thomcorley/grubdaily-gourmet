class CreateIngredientSets < ActiveRecord::Migration[5.1]
  def change
    create_table :ingredient_sets do |t|
      t.string :title
      t.integer :position

      t.timestamps
    end
  end
end
