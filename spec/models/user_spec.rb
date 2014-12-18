require 'rails_helper'

describe User do
  describe '::create_with_omniauth' do
    let(:oauth_params) do
      params = {}
      params['uid'] = 123
      info = params['info'] = {}
      info['name'] = 'alice'
      info['image'] = 'https://avatars.githubusercontent.com/u/1148320?v=2'
      info['email'] = 'alice@example.com'
      info['nickname'] = 'Alice-chan'
      info['location'] = 'Kobe'
      urls = info['urls'] = {}
      urls['GitHub'] = 'https://github.com/alice-foo-bar'
      urls['Blog'] = 'http://blog.example.com'

      params
    end

    it 'saves attributes' do
      user = User.create_with_omniauth(oauth_params)
      expected_attributes = {
          github_id: 123,
          name: 'alice',
          image: 'https://avatars.githubusercontent.com/u/1148320?v=2',
          email: 'alice@example.com',
          nickname: 'Alice-chan',
          location: 'Kobe',
          github_url: 'https://github.com/alice-foo-bar',
          blog: 'http://blog.example.com'
      }
      expect(user).to have_attributes(expected_attributes)
      expect(user).to be_persisted
    end
  end
end