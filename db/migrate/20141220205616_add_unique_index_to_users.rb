class AddUniqueIndexToUsers < ActiveRecord::Migration
  def change
    add_index :users, :github_id, unique: true
    add_index :users, :nickname, unique: true
  end
end
