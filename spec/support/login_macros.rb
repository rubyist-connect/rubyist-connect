module LoginMacros

  def sign_in_as_new_user(user = nil)
    user ||= create :inactive_user
    sign_in_via_github(user)
    user
  end

  def sign_in_as_registed_user(user = nil)
    user ||= create :user
    sign_in_via_github(user)
    user
  end

  def oauth_params(user)
    params = {}
    params['provider'] = 'github'
    params['uid'] = user.github_id
    info = params['info'] = {}
    info['name'] = user.name
    info['image'] = user.image
    info['email'] = user.email
    info['nickname'] = user.nickname
    info['location'] = user.location
    urls = info['urls'] = {}
    urls['GitHub'] = user.github_url
    urls['Blog'] = user.blog

    params
  end

  def sign_in_via_github(user)
    visit root_path

    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new(oauth_params(user))

    click_on 'Sign in with GitHub'
  end
end