source 'https://rubygems.org'

ruby '2.3.1'

gem 'rails', '5.0.6'

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
# TODO: Rails 5.1で解消される？
# https://github.com/hassox/warden/issues/147
gem 'warden', github: 'hassox/warden'

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
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'spring'
  gem 'letter_opener'
end

group :development, :test do
  gem 'rspec-rails'
  gem 'factory_girl_rails'
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
  gem 'poltergeist'
  gem 'database_cleaner'
  gem 'rspec-retry'
end
