class AddQiitaNamesToUsers < ActiveRecord::Migration[4.2]
  def change
    add_column :users, :qiita_name, :string
  end
end
