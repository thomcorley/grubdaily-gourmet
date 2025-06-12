require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module GrubdailyRails
  HEADER_LOGO = "https://s3.eu-west-2.amazonaws.com/grubdaily/grubdaily_white.png"
  FAVICON_LOGO_LARGE = "https://s3.eu-west-2.amazonaws.com/grubdaily/favicon_large.jpg"

  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    config.autoload_paths << "#{root}/app/grubdaily/*"
  end
end
