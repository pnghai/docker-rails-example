# frozen_string_literal: true

source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.3.3"

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "~> 7.1.3"

# The original asset pipeline for Rails [https://github.com/rails/sprockets-rails]
gem "sprockets-rails"

# Use postgresql as the database for Active Record
gem "pg", "~> 1.1"

# Use the Puma web server [https://github.com/puma/puma]
gem "puma", "~> 6.4"

# Bundle and transpile JavaScript [https://github.com/rails/jsbundling-rails]
gem "jsbundling-rails"

# Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
gem "turbo-rails"

# Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
gem "slim-rails"
gem "stimulus-rails"
# Bundle and process CSS [https://github.com/rails/cssbundling-rails]
gem "cssbundling-rails"

# Build JSON APIs with ease [https://github.com/rails/jbuilder]
gem "jbuilder"

# Use Redis adapter to run Action Cable in production
gem "hiredis-client"
gem "redis", "~> 5.2"
# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem "kredis"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
gem "bcrypt", "~> 3.1.7"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[mingw mswin x64_mingw jruby]

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
# gem "image_processing", "~> 1.2"

# Execute jobs in the background [https://github.com/mperham/sidekiq]
gem "sidekiq", "~> 7.2"

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "debug", platforms: %i[mri mingw x64_mingw]
  gem "rspec-rails", "~> 6.1", ">= 6.1.3"
  gem "rubocop-rspec", "~> 3.0", ">= 3.0.2"
  gem "simplecov"
end

group :development do
  # https://github.com/ctran/annotate_models
  gem "annotate"
  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem "active_record_query_trace"
  gem "awesome_print", "~> 2.0.0.pre2"
  gem "hotwire-livereload", "~> 1.4"
  gem "meta_request"
  gem "rubocop-performance", "~> 1.13", ">= 1.13.2"
  gem "rubocop-rails", "~> 2.25", ">= 2.25.1", require: false
  gem "web-console"
  gem "scout_apm"

  # Add speed badges [https://github.com/MiniProfiler/rack-mini-profiler]
  gem "better_errors"
  gem "rack-mini-profiler"
  gem "memory_profiler"
  gem "stackprof"
  # エラー画面でREPL実行できるように
  gem "binding_of_caller"
  # N+1問題を発見してくれる
  gem "bullet"
  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem "spring"
  gem "listen"
  gem "spring-watcher-listen", "~> 2.1"

  gem "hirb"
  # 本家hirb-unicodeは依存のunicode-display_widthが古く他のgemと相性が悪い
  gem "hirb-unicode-steakknife", github: "skull-squadron/hirb-unicode", branch: "main"
end

group :test do
  # Use system testing [https://guides.rubyonrails.org/testing.html#system-testing]
  gem "autodoc", "~> 0.8.0"
  gem "capybara"
  gem "database_rewinder", "~> 1.0", ">= 1.0.1"
  gem "json_spec", "~> 1.1", ">= 1.1.5"
  gem "rspec-request_describer", "~> 0.5.0"
  gem "selenium-webdriver"
end

gem "devise"
gem "devise-async"
gem "devise-i18n"
gem "devise-jwt"
gem "email_validator"
gem "factory_bot_rails", "~> 6.4", ">= 6.4.3"
gem "ffaker", "~> 2.23"
gem "marginalia"
gem "pagy", "~> 8.6"
gem "rails-i18n"
gem "rails-pg-extras"
gem "ransack"
gem "sidekiq-cron", "~> 1.12"
gem "sidekiq-failures"
gem "timeliness-i18n", "~> 0.12.1"
gem "validates_timeliness", "7.0.0.beta2"
# gem "sentry-ruby"
# gem "sentry-rails"
# TODO: https://github.com/smartinez87/exception_notification/tree/master
# TODO: https://github.com/theSteveMitchell/after_party
# https://github.com/Shopify/maintenance_tasks
# https://github.com/ankane/groupdate
# https://github.com/Wafris/wafris-rb
