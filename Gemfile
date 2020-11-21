source 'https://rubygems.org'

ruby '2.7.2'

gem 'rails', '6.0.3.4'

# UI/assets
gem 'uglifier'
gem 'jquery-rails'

gem 'coffee-rails'
gem 'sass-rails'
gem 'bootstrap-sass'
gem 'font-awesome-rails'
gem 'autoprefixer-rails'
gem 'slim-rails'
gem 'redcarpet'
gem 'kaminari'
gem 'kaminari-bootstrap'
gem 'page_title_helper'

# Authorization
gem 'devise'
gem 'omniauth'
gem 'omniauth-github'
gem 'omniauth-rails_csrf_protection', '~> 0.1'

# Models
gem 'ransack'
gem 'jc-validates_timeliness'
gem 'validate_url'
gem 'email_validator'

# Middleware
gem 'pg'
gem 'puma'
gem 'httpclient'

# Common
gem 'config'
gem 'hashie'

# Operation
gem 'newrelic_rpm'
gem 'rack-dev-mark'

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'spring'
  gem 'letter_opener'
  gem 'bundle_outdated_formatter'
end

group :development, :test do
  gem 'rspec-rails'
  gem 'factory_bot_rails'
  gem 'spring-commands-rspec'
  gem 'faker'
  gem 'dummy_text_jp'
end

group :test do
  gem 'capybara'
  gem 'launchy'
  gem 'timecop'
  gem 'vcr', require: false
  gem 'webmock', require: false
  gem 'selenium-webdriver'
  gem 'webdrivers'
  gem 'database_cleaner'
  gem 'rspec-retry'
end
