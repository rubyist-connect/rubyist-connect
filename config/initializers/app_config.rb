Rails.application.config.time_zone = 'Asia/Tokyo'
Rails.application.config.i18n.default_locale = :ja

Rails.application.config.generators do |g|
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
Rails.application.config.action_mailer.default_url_options = { host: Settings.host_name }
