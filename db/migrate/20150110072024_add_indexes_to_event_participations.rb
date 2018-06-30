class AddIndexesToEventParticipations < ActiveRecord::Migration[4.2]
  def change
    add_index :event_participations, :user_id
    add_index :event_participations, :event_id
  end
end
