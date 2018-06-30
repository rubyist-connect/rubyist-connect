class AddTwitterNameToUsers < ActiveRecord::Migration[4.2]
  def change
    add_column :users, :twitter_name, :string
  end
end
