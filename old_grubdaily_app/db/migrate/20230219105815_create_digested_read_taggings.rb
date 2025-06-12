class CreateDigestedReadTaggings < ActiveRecord::Migration[7.0]
  def change
    create_join_table :digested_reads, :tags, table_name: :digested_read_taggings, id: true do |t|
      t.primary_key :id
      t.index :digested_read_id
      t.index :tag_id
      t.timestamps
    end
  end
end
