class AddGithubIdToUsers < ActiveRecord::Migration[4.2]
  def change
    add_column :users, :github_id, :string
  end
end
