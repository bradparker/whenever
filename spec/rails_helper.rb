# This file is copied to spec/ when you run 'rails generate rspec:install'
require "spec_helper"
ENV["RAILS_ENV"] ||= "test"
ENV["DATABASE_URL"] = ENV.fetch("TEST_DATABASE_URL") do
  ENV.fetch("DATABASE_URL")
end

require File.expand_path("../config/environment", __dir__)

if Rails.env.production?
  abort("The Rails environment is running in production mode!")
end
require "rspec/rails"
require "view_component/test_helpers"

begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  puts e.to_s.strip
  exit 1
end

RSpec.configure do |config|
  config.filter_rails_from_backtrace!
  config.include ViewComponent::TestHelpers, type: :component
  config.infer_spec_type_from_file_location!
  config.use_transactional_fixtures = true
  config.before :suite do
    `bin/webpack`
  end
end
