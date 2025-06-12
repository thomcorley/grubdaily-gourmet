class EmailSubscriber < ApplicationRecord
  email_local_part_pattern = "[&a-zA-Z0-9#'+_-]+(?:\\.[&a-zA-Z0-9#'+_-]+)*"
  email_domain_pattern = "(?:[a-zA-Z0-9](?:[a-zA-Z0-9-]*[a-zA-Z0-9])?\\.)+[a-zA-Z0-9](?:[a-zA-Z0-9-]*[a-zA-Z0-9])?"
  EMAIL_PATTERN = "#{email_local_part_pattern}@#{email_domain_pattern}"
  EMAIL_REGEX = /\A#{EMAIL_PATTERN}\z/

  validates :email, format: { with: EMAIL_REGEX, message: "is an invalid format" }
  validates :email, uniqueness: { message: "is already subscribed"}

  scope :confirmed, -> { where(confirmed: true) }

  def confirm!
    self.update!(confirmed: true)
  end

  def unsubscribe!
    self.update!(confirmed: false)
  end
end
