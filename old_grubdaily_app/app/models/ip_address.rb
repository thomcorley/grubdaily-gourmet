class IpAddress < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :ip_address, presence: true, uniqueness: true

  scope :admin, -> { where(admin_access: true).where("admin_access_expires > ?", DateTime.now) }
end
