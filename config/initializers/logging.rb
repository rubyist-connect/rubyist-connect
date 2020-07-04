Rails.configuration.log_tags = [
  :request_id,
  -> (request) {
    session_key = (Rails.application.config.session_options || {})[:key]
    session_data = request.cookie_jar.encrypted[session_key] || {}

    # warden.user.user.key で User#id を取得
    session_data.dig("warden.user.user.key", 0, 0)
  }
]
