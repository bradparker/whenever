# frozen_string_literal: true

source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "~> 2.6"

gem "pg", ">= 0.18", "< 2.0"
gem "puma", "~> 4.1"
gem "rails", "~> 6.0.2", ">= 6.0.2.1"
gem "sirp", "~> 2.0"
gem "tailwindcss", "~> 1.0"
gem "turbolinks", "~> 5"
gem "view_component", "~> 1.16"
gem "webpacker", "~> 4.0"

gem "bootsnap", ">= 1.4.2", require: false

group :development, :test do
  gem "byebug", platforms: %i[mri mingw x64_mingw]
  gem "rspec-rails", "~> 3.9"
end

group :development do
  gem "listen", ">= 3.0.5", "< 3.2"
  gem "rufo", "~> 0.12.0"
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
  gem "web-console", ">= 3.3.0"
end

group :test do
  gem "degenerate", "~> 0.0.3"
  gem "generative", "~> 0.2.4"
  gem "rails-controller-testing", "~> 1.0"
  gem "timecop", "~> 0.9.1"
end
