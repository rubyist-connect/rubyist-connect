class CreateInterests < ActiveRecord::Migration[4.2]
  def change
    create_table :interests do |t|
      t.integer :user_id
      t.string :content
      t.string :content_url

      t.timestamps
    end
  end
end
