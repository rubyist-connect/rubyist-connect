source 'https://rubygems.org'

ruby '2.3.1'

gem 'rails', '5.0.6'

# UI/assets
gem 'uglifier', '>= 1.3.0'
gem 'jquery-rails', '~> 4.2.1'

gem 'coffee-rails', '~> 4.2.1'
gem 'sass-rails', '~> 5.0.6'
gem 'bootstrap-sass', '~> 3.3.7'
gem 'font-awesome-rails', '~> 4.6.3'
gem 'autoprefixer-rails', '~> 6.5.0'
gem 'slim-rails', '~> 3.1.1'
gem 'redcarpet', '~> 3.3.4'
gem 'kaminari', '~> 0.17.0'
gem 'kaminari-bootstrap', '~> 3.0.1'
gem 'page_title_helper', '~> 2.1.0'

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
