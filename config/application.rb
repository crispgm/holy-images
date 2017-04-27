require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

require_relative "../lib/ext/date_and_time/calculations"

module Holyimage
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # time zone
    config.time_zone = "Beijing"

    # ImageMagick runtime
    config.runtime_path = ENV["APP_PREFIX"] || "."

    # i18n
    config.i18n.default_locale = "zh-CN"
    config.i18n.fallbacks = true
    config.i18n.fallbacks = [:en]

    # Mail settings
    config.action_mailer.delivery_method = :sendmail
    config.action_mailer.smtp_settings = {
      :address => "localhost",
      :port    => 25
    }
    config.action_mailer.perform_deliveries = true
    config.action_mailer.raise_delivery_errors = true
    config.action_mailer.default_url_options = {
      :host => ENV["SERVER_NAME"] || "localhost:3000"
    }

    # add external assets
    config.assets.paths << Rails.root.join('vendor', 'assets')
  end
end
