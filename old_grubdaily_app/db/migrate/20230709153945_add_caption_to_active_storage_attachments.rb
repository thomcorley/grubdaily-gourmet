class AddCaptionToActiveStorageAttachments < ActiveRecord::Migration[7.0]
  def change
    add_column :active_storage_attachments, :caption, :string
  end
end
