# frozen_string_literal: true

source "https://rubygems.org"

ruby "2.5.9"

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem "rails", "4.2.11.3"
# Use postgres as the database for Active Record
gem "pg", "~> 0.15"
# Use SCSS for stylesheets
gem "sass-rails" # , '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem "uglifier" # , '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem "coffee-rails" # , '~> 4.1.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem "jquery-rails"
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem "turbolinks"
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem "jbuilder", "~> 2.0"
# bundle exec rake doc:rails generates the API under doc/api.
gem "sdoc", "~> 0.4.0", group: :doc

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

gem "logging"
gem "spreadsheet"

# Lock version for gems with issues in older ruby/rails versions
gem "ffi", "< 1.17.0"
gem "bigdecimal", "1.3.5"

group :development, :test do
  gem "byebug"
  gem "capybara"
  gem "database_cleaner"
  gem "factory_bot_rails"
  gem "pry-rails"
  gem "rspec-rails"
  gem "selenium-webdriver"

  # Access an IRB console on exception pages or by using <%= console %> in views
  # gem 'web-console', '~> 2.0'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem "spring", "< 3.0"

  gem "rack-rewrite"

  gem "erb_lint"
  gem "rubocop"
  gem "rubocop-rails"
  gem "rubocop-rspec"
  gem "solargraph"
  gem "solargraph-rails"
  gem "standard"
end

group :test do
  gem "simplecov", require: false
end
