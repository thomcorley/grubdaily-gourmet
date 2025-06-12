class ApplicationController < ActionController::Base
  include ApplicationHelper
  include Logging

  self.page_cache_directory = -> {
    Rails.root.join("public", request.domain)
  }

  protect_from_forgery with: :exception

  before_action do
    ActiveStorage::Current.url_options = { host: Rails.configuration.active_storage.host }
  end

  def not_found
    render file: "#{Rails.root}/public/404.html",  layout: false, status: 404
  end

  def authenticate
    not_found unless admin_session?
  end

  def subscriber_count
    EmailSubscriber.confirmed.count
  end
end
