Rails.application.default_url_options[:host] = "http://localhost:2020"

Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  config.log_level = :debug

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports.
  config.consider_all_requests_local = true

  # Enable/disable caching. By default caching is disabled.
  if Rails.root.join('tmp/caching-dev.txt').exist?
    config.action_controller.perform_caching = true

    config.cache_store = :memory_store
    config.public_file_server.headers = {
      'Cache-Control' => "public, max-age=#{2.days.seconds.to_i}"
    }
  else
    config.action_controller.perform_caching = false

    config.cache_store = :null_store
  end

  config.action_controller.asset_host = "localhost:2020"

  # Don't care if the mailer can't send.
  config.action_mailer.raise_delivery_errors = false

  config.action_mailer.perform_caching = false

  config.action_mailer.default_url_options = { host: "http://localhost:2020" }

  config.action_mailer.asset_host = "http://localhost:2020"

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations.
  config.active_record.migration_error = :page_load

  # Debug mode disables concatenation and preprocessing of assets.
  # This option may cause significant delays in view rendering with a large
  # number of complex assets.
  # config.assets.debug = true

  # Suppress logger output for asset requests.
  config.assets.quiet = true
  config.assets.check_precompiled_asset = false

  # Only load images when they come into view
  config.action_view.image_loading = "lazy"

  # Raises error for missing translations
  # config.action_view.raise_on_missing_translations = true

  # Use an evented file watcher to asynchronously detect changes in source code,
  # routes, locales, etc. This feature depends on the listen gem.
  config.file_watcher = ActiveSupport::EventedFileUpdateChecker

  config.action_mailer.delivery_method = :mailgun

  config.action_mailer.mailgun_settings = {
    api_key: Rails.application.credentials.dig(:mailgun, :api_key),
    domain: "sandbox26bf25bdfd394def8172bb54ea809d61.mailgun.org",
  }

  config.hosts << "lvh.me"
  config.hosts << "api.lvh.me"

  # Store files locally
  config.active_storage.service = :local
  config.active_storage.host = "http://localhost:2020"
  config.active_storage.cdn_host = "localhost:2020"
end
