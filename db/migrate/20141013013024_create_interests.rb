class CreateInterests < ActiveRecord::Migration
  def change
    create_table :interests do |t|
      t.integer :user_id
      t.string :content
      t.string :content_url

      t.timestamps
    end
  end
end
