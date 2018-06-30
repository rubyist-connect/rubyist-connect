class AddBlogToUsers < ActiveRecord::Migration[4.2]
  def change
    add_column :users, :blog, :string
  end
end
