module AppConstants
  email_local_part_pattern = "[&a-zA-Z0-9#'+_-]+(?:\\.[&a-zA-Z0-9#'+_-]+)*"
  email_domain_pattern = "(?:[a-zA-Z0-9](?:[a-zA-Z0-9-]*[a-zA-Z0-9])?\\.)+[a-zA-Z0-9](?:[a-zA-Z0-9-]*[a-zA-Z0-9])?"
  EMAIL_PATTERN = "#{email_local_part_pattern}@#{email_domain_pattern}"
  EMAIL_REGEX = /\A#{AppConstants::EMAIL_PATTERN}\z/
end
