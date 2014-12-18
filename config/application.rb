require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module RubyistConnect
  class Application < Rails::Application
    config.time_zone = 'Asia/Tokyo'

    config.i18n.default_locale = :ja

    config.generators do |g|
      g.test_framework :rspec,
                       fixtures: false,
                       view_specs: false,
                       controller_specs: false,
                       helper_specs: false,
                       routing_specs: false,
                       request_specs: false
      g.assets false
      g.helper false
      g.javascripts false
      g.stylesheets false
      g.fixture_replacement :factory_girl, dir: 'spec/factories'
    end
  end
end
