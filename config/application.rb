require_relative 'boot'

require 'rails/all'

Bundler.require(*Rails.groups)

module Whenever
  class Application < Rails::Application
    config.load_defaults 6.0

    config.webpacker.check_yarn_integrity false
  end
end
