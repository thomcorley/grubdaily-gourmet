class AddConfirmedToEmailSubscribers < ActiveRecord::Migration[6.0]
  def change
    add_column :email_subscribers, :confirmed, :boolean
  end
end
