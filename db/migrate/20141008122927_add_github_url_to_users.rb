class AddGithubUrlToUsers < ActiveRecord::Migration[4.2]
  def change
    add_column :users, :github_url, :string
  end
end
