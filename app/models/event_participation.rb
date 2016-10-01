class EventParticipation < ApplicationRecord
  belongs_to :event
  belongs_to :user

  # TODO: Event.create(name: 'hoge', user_ids: [1, 2]) がエラーになる
  # validates :event_id, presence: true
  # validates :user_id, presence: true

  def previous_user
    self.event.users.where("users.id < ?", user.id).reorder("users.id DESC").first
  end

  def next_user
    self.event.users.where("users.id > ?", user.id).reorder("users.id ASC").first
  end
end
