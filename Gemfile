source 'https://rubygems.org'

ruby '2.3.1'

gem 'rails', '4.2.4'

# UI/assets
gem 'sass-rails', '~> 4.0.3'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'jquery-rails'
gem 'turbolinks'
gem 'jquery-turbolinks'
gem 'jbuilder', '~> 2.0'
gem 'font-awesome-rails'
gem 'slim-rails'
gem 'bootstrap-sass', '~> 3.3.1'
gem 'autoprefixer-rails'
gem 'redcarpet', '~> 3.2.2'
gem 'kaminari'
gem 'kaminari-bootstrap'
gem 'page_title_helper'

# Authorization
gem 'devise', '~> 4.1.0'
gem 'omniauth', '~> 1.3.1'
gem 'omniauth-github', '~> 1.1.2'

# Models
gem 'ransack'
gem 'jc-validates_timeliness'
gem 'validate_url'
gem 'email_validator'

# Middleware
gem 'pg'
gem 'puma'

# Common
gem 'config', '~> 1.3.0'
gem 'hashie'

# Operation
gem 'newrelic_rpm', '~> 3.16.3'
gem 'rack-dev-mark', '~> 0.7.5'

group :production, :staging do
  gem 'rails_12factor'
end

group :development do
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'spring'
  gem 'heroku_san'
  gem 'i18n_generators'
  gem 'quiet_assets'
  gem 'letter_opener'
end

group :development, :test do
  gem 'rspec-rails', '~> 3.5.0'
  gem 'factory_girl_rails', '~> 4.7.0'
  gem 'spring-commands-rspec', '~> 1.0.2'
  gem 'faker', '~> 1.6.6'
  gem 'dummy_text_jp'
end

group :test do
  gem 'capybara', '~> 2.9.2'
  gem 'launchy', '~> 2.4.3'
  gem 'timecop', '~> 0.8.1'
  gem 'vcr', '~> 3.0.3', require: false
  gem 'webmock', '2.1.0', require: false
  gem 'poltergeist', '~> 1.10.0'
  gem 'database_cleaner', '~> 1.5.3'
end
