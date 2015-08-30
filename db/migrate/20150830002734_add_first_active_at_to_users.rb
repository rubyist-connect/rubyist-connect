class AddFirstActiveAtToUsers < ActiveRecord::Migration
  def change
    add_column :users, :first_active_at, :datetime
  end
end
