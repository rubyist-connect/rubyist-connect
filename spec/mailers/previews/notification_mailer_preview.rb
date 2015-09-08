class NotificationMailerPreview < ActionMailer::Preview
  # Preview this email at http://rubyist-connect.dev/rails/mailers/notification_mailer/new_user_notification
  def new_user_notification
    new_user = User.last
    target_users = User.first(3)
    NotificationMailer.new_user_notification(target_users, new_user)
  end
end
