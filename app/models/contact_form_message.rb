class ContactFormMessage
  include ActiveModel::Validations

  attr_accessor :name, :email, :message, :subscribe

  validates_presence_of :name, :email, :message, :subscribe
  validates :email, format: { with: AppConstants::EMAIL_REGEX, message: "invalid" }

  def initialize(name: nil, email: nil, message: nil, subscribe: nil)
    @name = name
    @email = email
    @message = message
    @subscribe = subscribe
  end

  # converts the raw data from the HTML form
  def subscribe?
    subscribe == "1"
  end
end
