class CreateMethodSteps < ActiveRecord::Migration[5.1]
  def change
    create_table :method_steps do |t|
      t.integer :position
      t.text :description

      t.timestamps
    end
  end
end
