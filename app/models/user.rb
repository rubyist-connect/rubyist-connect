class User < ActiveRecord::Base
  devise :trackable, :omniauthable, omniauth_providers: [:github]

  has_many :interests

  validates :github_id, presence: true, uniqueness: true
  # ユーザ設定画面のpathと重複するのでeditさんのアカウント登録はNGとする
  validates :nickname, presence: true, uniqueness: true, format: { without: /\Aedit\z/i }

  validates_date :birthday, allow_blank: true
  validates_date :be_rubyist_at, allow_blank: true

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

  # TODO Ransackを使うと便利です
  def self.search(query)
    if query
      User.where(['name like ?', "%#{query}%"])
    else
      User.all
    end
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

  def rubyist_year_month
    return if be_rubyist_at.blank?
    today = Date.current
    today_months = today.year * 12 + today.month
    rubyist_months = be_rubyist_at.year * 12 + be_rubyist_at.month
    months = today_months - rubyist_months
    return months / 12, months % 12
  end
end
