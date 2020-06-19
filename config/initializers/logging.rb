Rails.configuration.log_tags = [
  :request_id,
  -> (request) {
    session_key = (Rails.application.config.session_options || {})[:key]
    session_data = request.cookie_jar.encrypted[session_key] || {}

    user_id = session_data.dig("warden.user.user.key", 0, 0)
    User.find(user_id).nickname if user_id
  }
]
