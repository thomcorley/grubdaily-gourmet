class CreateDigestedReads < ActiveRecord::Migration[6.1]
  def change
    create_table :digested_reads do |t|
      t.string :title
      t.string :summary
      t.text :content
      t.text :excerpt
      t.string :book_cover_image
      t.string :affiliate_link
      t.text :author_info
      t.string :tags
      t.datetime :published_at

      t.timestamps
    end
  end
end
