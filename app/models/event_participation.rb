class EventParticipation < ActiveRecord::Base
  belongs_to :event
  belongs_to :user

  # TODO: Event.create(name: 'hoge', user_ids: [1, 2]) がエラーになる
  # validates :event_id, presence: true
  # validates :user_id, presence: true
end
