class AddNewUserNotificationEnabledToUser < ActiveRecord::Migration[4.2]
  def change
    add_column :users, :new_user_notification_enabled, :boolean, null: false, default: false
  end
end
