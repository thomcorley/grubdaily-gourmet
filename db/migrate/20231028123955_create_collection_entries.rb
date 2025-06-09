class CreateCollectionEntries < ActiveRecord::Migration[7.0]
  def change
    create_join_table :collections, :entries, table_name: :collection_entries do |t|
      t.primary_key :id
      t.index :collection_id
      t.index :entry_id
      t.timestamps
    end
  end
end
