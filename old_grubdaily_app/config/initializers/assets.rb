# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path.
Rails.application.config.assets.paths << Rails.root.join('app', 'assets', 'fonts')
Rails.application.config.assets.paths << Rails.root.join('app', 'assets', 'icons')
# Add Yarn node_modules folder to the asset load path.
# Rails.application.config.assets.paths << Rails.root.join('node_modules')


# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in the app/assets
# folder are already added.
Rails.application.config.assets.precompile += %w(navbar flickity app/javascript/ingredient_sets_form)

# This will affect assets served from /app/assets
Rails.application.config.static_cache_control = 'public, max-age=2630000'

# This will affect assets in /public, e.g. webpacker assets.
Rails.application.config.public_file_server.headers = {
  'Cache-Control' => 'public, max-age=2630000',
  'Expires' => 1.year.from_now.to_formatted_s(:rfc822)
}
