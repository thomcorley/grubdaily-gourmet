class AddDescriptionToImageUploads < ActiveRecord::Migration[7.0]
  def change
    add_column :image_uploads, :description, :string
  end
end
