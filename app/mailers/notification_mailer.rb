class NotificationMailer < ApplicationMailer
  def new_user_notification(target_users, new_user)
    return if target_users.blank?
    @new_user = new_user
    mail to: [], bcc: target_users.map(&:email), subject: '新しいRubyistが登録されました！'
  end
end
