require_relative "boot"

require "rails/all"
require "view_component/engine"

Bundler.require(*Rails.groups)

module Whenever
  class Application < Rails::Application
    config.load_defaults 6.0
  end
end
