class CreateCollections < ActiveRecord::Migration[7.0]
  def change
    create_table :collections do |t|
      t.string :title
      t.text :introduction

      t.timestamps
    end
  end
end
