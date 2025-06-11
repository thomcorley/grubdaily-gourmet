class FixActiveStorageBlobKeys < ActiveRecord::Migration[8.0]
  def up
    # Update blob keys to use filenames since files are stored in S3 with original names
    ActiveStorage::Blob.find_each do |blob|
      original_key = blob.key
      filename_key = blob.filename.to_s
      
      if original_key != filename_key
        puts "Updating blob key: #{original_key} -> #{filename_key}"
        blob.update_column(:key, filename_key)
      end
    end
  end

  def down
    # This migration is not easily reversible since we don't store the original keys
    # You would need to restore from a backup if needed
    raise ActiveRecord::IrreversibleMigration
  end
end
