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
gem 'devise', '~> 4.2.0'
gem 'omniauth', '~> 1.3.1'
gem 'omniauth-github', '~> 1.1.2'

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
  gem 'heroku_san'
  gem 'i18n_generators'
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
