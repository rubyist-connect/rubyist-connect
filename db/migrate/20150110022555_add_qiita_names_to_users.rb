class AddQiitaNamesToUsers < ActiveRecord::Migration
  def change
    add_column :users, :qiita_name, :string
  end
end
