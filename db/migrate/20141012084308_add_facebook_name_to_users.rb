class AddFacebookNameToUsers < ActiveRecord::Migration[4.2]
  def change
    add_column :users, :facebook_name, :string
  end
end
