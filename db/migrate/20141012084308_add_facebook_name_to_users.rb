class AddFacebookNameToUsers < ActiveRecord::Migration
  def change
    add_column :users, :facebook_name, :string
  end
end
