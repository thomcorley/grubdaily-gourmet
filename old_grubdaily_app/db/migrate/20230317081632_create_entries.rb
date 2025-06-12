class CreateEntries < ActiveRecord::Migration[7.0]
  def change
    create_table :entries do |t|
      t.string :title
      t.string :summary
      t.text :content
      t.string :entryable_type
      t.integer :entryable_id
      t.datetime :published_at
      t.datetime :marked_for_promotion_at

      t.timestamps
    end
  end
end
