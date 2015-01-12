class User < ActiveRecord::Base

  scope :active, -> {
    introduction = arel_table[:introduction]
    where(introduction.not_eq(nil).and(introduction.not_eq('')))
  }

  devise :trackable, :omniauthable, omniauth_providers: [:github]

  has_many :event_participations, dependent: :destroy
  has_many :events, through: :event_participations

  validates :github_id, presence: true, uniqueness: true
  # ユーザ設定画面のpathと重複するのでeditさんのアカウント登録はNGとする
  validates :nickname, presence: true, uniqueness: true, format: { without: /\Aedit\z/i }

  validates_date :birthday, allow_blank: true

  def self.find_or_create_from_auth_hash(auth_hash)
    find_by_github_id(auth_hash['uid']) || create_with_omniauth(auth_hash)
  end

  def self.create_with_omniauth(oauth)
    user = User.new
    user.github_id = oauth['uid']

    user.name       = oauth['info']['name']
    user.image      = oauth['info']['image']
    user.email      = oauth['info']['email']
    user.nickname   = oauth['info']['nickname']
    user.location   = oauth['info']['location']
    user.github_url = oauth['info']['urls']['GitHub']
    user.blog       = oauth['info']['urls']['Blog']

    user.save!

    return user
  end

  def name_or_nickname
    name.presence || nickname
  end

  def age
    return if birthday.blank?
    d1 = birthday.strftime("%Y%m%d").to_i
    d2 = Date.current.strftime("%Y%m%d").to_i
    (d2 - d1) / 10000
  end

  def active?
    introduction.present?
  end
end
