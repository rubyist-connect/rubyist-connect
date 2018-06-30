class CreateEventParticipations < ActiveRecord::Migration[4.2]
  def change
    create_table :event_participations do |t|
      t.integer :user_id
      t.integer :event_id

      t.timestamps
    end
  end
end
