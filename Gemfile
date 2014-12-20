source 'https://rubygems.org'

ruby '2.1.5'

gem 'rails', '4.1.8'
gem 'pg'
gem 'sass-rails', '~> 4.0.3'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'

gem 'jquery-rails'
gem 'turbolinks'
gem 'jbuilder', '~> 2.0'
gem 'sdoc', '~> 0.4.0',          group: :doc

gem 'devise'
gem 'omniauth'
gem 'omniauth-github'
gem 'font-awesome-rails'
gem 'unicorn'
gem 'newrelic_rpm'
gem 'rails_config'
gem 'slim-rails'

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
end

group :development, :test do
  gem 'rspec-rails', '~> 3.1.0'
  gem 'factory_girl_rails', '~> 4.5.0'
  gem 'spring-commands-rspec', '~> 1.0.2'
end

group :test do
  gem 'capybara', '~> 2.4.4'
  gem 'launchy'
end