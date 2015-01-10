module LoginMacros
  def oauth_params
    params = {}
    params['provider'] = 'github'
    params['uid'] = '123'
    info = params['info'] = {}
    info['name'] = 'Alice'
    info['image'] = 'https://avatars.githubusercontent.com/u/1148320?v=2'
    info['email'] = 'alice@example.com'
    info['nickname'] = 'alice'
    info['location'] = 'Kobe'
    urls = info['urls'] = {}
    urls['GitHub'] = 'https://github.com/alice-foo-bar'
    urls['Blog'] = 'http://blog.example.com'

    params
  end

  def sign_in_as_new_user
    visit root_path

    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new(oauth_params)

    click_on 'Sign in with GitHub'
  end
end