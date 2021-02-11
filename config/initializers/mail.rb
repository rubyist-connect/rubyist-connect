if Rails.env.staging? or Rails.env.production?
  ActionMailer::Base.smtp_settings = {
    :port           => ENV['MAILGUN_SMTP_PORT'],
    :address        => ENV['MAILGUN_SMTP_SERVER'],
    :user_name      => ENV['MAILGUN_SMTP_LOGIN'],
    :password       => ENV['MAILGUN_SMTP_PASSWORD'],
    :domain         => ENV['HOST_NAME'],
    :authentication => :plain,
  }
  ActionMailer::Base.delivery_method = :smtp
end
Rails.application.config.action_mailer.default_url_options = Rails.application.default_url_options = { protocol: 'https', host: Settings.host_name }
