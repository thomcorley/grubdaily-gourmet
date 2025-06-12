class CreateEntryTaggings < ActiveRecord::Migration[7.0]
  def change
    create_join_table :entries, :tags, table_name: :entry_taggings do |t|
      t.primary_key :id
      t.index :entry_id
      t.index :tag_id
      t.timestamps
    end
  end
end
