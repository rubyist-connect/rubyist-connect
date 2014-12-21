require 'rails_helper'

describe User do
  describe '::create_with_omniauth' do
    let(:params) do
      params = {}
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

    it 'saves attributes' do
      user = User.create_with_omniauth(params)
      expected_attributes = {
          github_id: '123',
          name: 'Alice',
          image: 'https://avatars.githubusercontent.com/u/1148320?v=2',
          email: 'alice@example.com',
          nickname: 'alice',
          location: 'Kobe',
          github_url: 'https://github.com/alice-foo-bar',
          blog: 'http://blog.example.com'
      }
      expect(user).to have_attributes(expected_attributes)
      expect(user).to be_persisted
    end
  end

  describe 'validation' do
    it 'editは無効なnicknameとすること' do
      user = User.new(github_id: '123', nickname: 'Alice')
      expect(user).to be_valid

      user.nickname = 'edit'
      expect(user).to be_invalid

      user.nickname = 'Edit'
      expect(user).to be_invalid
    end
  end
end