require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

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
  end
end
