class AddBirthdayToUser < ActiveRecord::Migration[4.2]
  def change
    add_column :users, :birthday, :date
  end
end
