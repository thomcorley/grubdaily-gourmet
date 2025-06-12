class CreateImageUploads < ActiveRecord::Migration[7.0]
  def change
    create_table :image_uploads do |t|
      t.string :title
      t.string :website_url
      t.datetime :published_at

      t.timestamps
    end
  end
end
