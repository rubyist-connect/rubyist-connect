class AddProfileUpdatedAtToUsers < ActiveRecord::Migration
  def change
    add_column :users, :profile_updated_at, :datetime
  end
end
