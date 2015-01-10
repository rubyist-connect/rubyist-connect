class AddBeRubyistAtToUser < ActiveRecord::Migration
  def change
    add_column :users, :be_rubyist_at, :date
  end
end
