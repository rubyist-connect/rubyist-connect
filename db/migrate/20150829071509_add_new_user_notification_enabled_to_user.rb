class AddNewUserNotificationEnabledToUser < ActiveRecord::Migration
  def change
    add_column :users, :new_user_notification_enabled, :boolean, null: false, default: false
  end
end
