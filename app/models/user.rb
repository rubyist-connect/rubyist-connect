class User < ActiveRecord::Base
  devise :omniauthable, omniauth_providers: [:github]

  has_many :interests

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
end
