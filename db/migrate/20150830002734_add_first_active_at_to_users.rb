class AddFirstActiveAtToUsers < ActiveRecord::Migration[4.2]
  def change
    add_column :users, :first_active_at, :datetime
  end
end
