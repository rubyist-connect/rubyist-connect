class User < ApplicationRecord
  devise :trackable, :omniauthable, omniauth_providers: [:github]

  has_many :event_participations, dependent: :destroy
  has_many :events, through: :event_participations

  scope :active, -> {
    introduction = arel_table[:introduction]
    where(introduction.not_eq(nil).and(introduction.not_eq('')))
  }

  scope :without_login_user, -> (user) {
    where.not(id: user.id) if user.present?
  }

  validates :github_id, presence: true, uniqueness: true
  # ユーザ設定画面のpathと重複するのでeditさんのアカウント登録はNGとする
  validates :nickname, presence: true, uniqueness: true, format: { without: /\Aedit\z/i }

  validates :email, email: true, allow_blank: true
  validates :email, presence: true, if: :new_user_notification_enabled?

  validates_date :birthday, allow_blank: true

  before_save :set_first_active_at, if: -> { !was_active? && active? }

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

  # 既存データ更新用のメソッド。画面からは呼ばれない。
  def self.update_first_active_at_for_existing_users!
    User.active.update_all(first_active_at: Time.current)
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

  def first_active?
    !was_active? && active? && first_active_at.blank?
  end

  private

  def was_active?
    introduction_was.present?
  end

  def set_first_active_at
    self.first_active_at = Time.current
  end
end
