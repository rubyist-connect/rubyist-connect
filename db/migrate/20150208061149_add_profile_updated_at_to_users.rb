class AddProfileUpdatedAtToUsers < ActiveRecord::Migration[4.2]
  def change
    add_column :users, :profile_updated_at, :datetime
  end
end
