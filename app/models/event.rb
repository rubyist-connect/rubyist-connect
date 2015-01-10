class Event < ActiveRecord::Base
  has_many :participations, class_name: EventParticipation.name
  has_many :users, through: :participations
end
