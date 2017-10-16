source 'https://rubygems.org'

ruby '2.3.1'

gem 'rails', '5.0.0.1'

# UI/assets
gem 'uglifier', '>= 1.3.0'
gem 'jquery-rails', '~> 4.2.1'

# https://github.com/kossnocorp/jquery.turbolinks/issues/61
gem 'turbolinks', '< 5.0'
gem 'jquery-turbolinks', '~> 2.1.0'

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
gem 'ransack', '~> 1.8.2'
gem 'jc-validates_timeliness', '~> 3.1.1'
gem 'validate_url', '~> 1.0.2'
gem 'email_validator', '~> 1.6.0'

# Middleware
gem 'pg', '~> 0.19.0'
gem 'puma', '~> 3.6.0'
gem 'httpclient', '~> 2.8.2'

# Common
gem 'config', '~> 1.3.0'
gem 'hashie', '~> 3.4.6'

# Operation
gem 'newrelic_rpm', '~> 3.16.3'
gem 'rack-dev-mark', '~> 0.7.5'

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
