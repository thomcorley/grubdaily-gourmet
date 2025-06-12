class CreateIpAddresses < ActiveRecord::Migration[6.0]
  def change
    create_table :ip_addresses do |t|
      t.string :ip_address
      t.string :name
      t.boolean :admin_access
      t.datetime :admin_access_expires
    end
  end
end
