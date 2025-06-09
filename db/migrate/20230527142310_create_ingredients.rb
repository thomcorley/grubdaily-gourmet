class CreateIngredients < ActiveRecord::Migration[7.0]
  def change
    create_table :ingredients do |t|
      t.string :name
      t.string :synonyms
      t.text :content
      t.integer :animal_status
      t.json :nutrition
      t.boolean :publishable

      t.timestamps
    end
  end
end
