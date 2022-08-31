source 'https://rubygems.org'

ruby '3.0.0'

gem 'rails', '6.1.3.1'

# UI/assets
gem 'uglifier'
gem 'jquery-rails'

gem 'bootsnap', '>= 1.4.4', require: false
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
gem 'sendgrid-actionmailer'

# Authorization
gem 'devise'
gem 'omniauth', '~> 1.9.2' # Deviseが対応するまで2.0に上げない
gem 'omniauth-github'
gem 'omniauth-rails_csrf_protection', '~> 0.1'

# Models
gem 'ransack'
gem 'jc-validates_timeliness'
gem 'validate_url'
gem 'email_validator'

# Middleware
gem 'pg'
gem 'puma', '~> 5.0'
gem 'httpclient'

# Common
gem 'config'
gem 'hashie'

# Operation
gem 'newrelic_rpm'
gem 'rack-dev-mark'

group :development do
  gem 'listen', '~> 3.3'
  gem 'spring'
  gem 'letter_opener'
  gem 'bundle_outdated_formatter'
  gem 'web-console', '>= 4.1.0'
  gem 'rack-mini-profiler', '~> 2.0'
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
