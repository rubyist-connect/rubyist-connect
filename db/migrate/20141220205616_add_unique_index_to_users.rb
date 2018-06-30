class AddUniqueIndexToUsers < ActiveRecord::Migration[4.2]
  def change
    add_index :users, :github_id, unique: true
    add_index :users, :nickname, unique: true
  end
end
