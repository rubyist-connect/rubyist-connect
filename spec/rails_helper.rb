ENV["RAILS_ENV"] ||= 'test'
require 'spec_helper'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'faker'
require 'vcr'
require 'capybara/poltergeist'

Dir[Rails.root.join('spec/support/**/*.rb')].each {|f| require f }

ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  config.include LoginMacros, type: :feature

  config.use_transactional_fixtures = false

  config.infer_spec_type_from_file_location!

  config.include FactoryGirl::Syntax::Methods

  # Devise をテスト可能にする
  # https://github.com/plataformatec/devise#test-helpers
  config.include Devise::TestHelpers, type: :controller

  # open_on_error: trueのFeature specが落ちたらsave_and_open_pageをコールする
  # http://stackoverflow.com/a/16935806/1058763
  config.after do |example|
    if example.metadata[:type] == :feature and example.exception.present? and example.metadata[:open_on_error] == true
      save_and_open_page
    end
  end

  VCR.configure do |c|
    c.cassette_library_dir = 'spec/vcr'
    c.hook_into :webmock
    c.allow_http_connections_when_no_cassette = true
  end

  Capybara.javascript_driver = :poltergeist

  require 'database_cleaner'
  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    Faker::Config.locale = :en
    DatabaseCleaner.strategy = :transaction
  end

  config.before(:each, js: true) do
    DatabaseCleaner.strategy = :truncation
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
end
