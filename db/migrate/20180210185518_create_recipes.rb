class CreateRecipes < ActiveRecord::Migration[5.1]
  def change
    create_table :recipes do |t|
      t.string :title
      t.text :summary
      t.string :total_time
      t.text :introduction
      t.integer :serves
      t.integer :makes
      t.string :makes_unit
      t.string :type

      t.timestamps
    end
  end
end
