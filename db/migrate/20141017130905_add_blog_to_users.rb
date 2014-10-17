class AddBlogToUsers < ActiveRecord::Migration
  def change
    add_column :users, :blog, :string
  end
end
