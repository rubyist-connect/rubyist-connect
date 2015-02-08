class Event < ActiveRecord::Base
  has_many :participations, class_name: EventParticipation.name, dependent: :destroy
  has_many :users, through: :participations

  validates :name, presence: true
  validates :url, url: {allow_blank: true}

end
