if Rails.env.staging? or Rails.env.production?
  ActionMailer::Base.delivery_method = :sendgrid_actionmailer
  ActionMailer::Base.sendgrid_actionmailer_settings = {
    api_key: ENV['SENDGRID_API_KEY'],
    raise_delivery_errors: true
  }
end
Rails.application.config.action_mailer.default_url_options = Rails.application.default_url_options = { protocol: 'https', host: Settings.host_name }
