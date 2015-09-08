class NotificationMailer < ApplicationMailer
  def new_user_notification(target_users, new_user)
    return if target_users.blank?
    @new_user = new_user
    mail to: [], bcc: target_users.map(&:email), subject: "#{subject_prefix} 新しいRubyistが登録されました！"
  end

  private

  def subject_prefix
    env = Rails.env.production? ? '' : "-#{Rails.env}"
    "[Rubyist Connect#{env}]"
  end
end
