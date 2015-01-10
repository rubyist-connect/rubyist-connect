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

  describe '#age' do
    before do
      Timecop.travel(2013, 1, 10)
    end
    it '年齢が自動計算されること' do
      user = User.new(birthday: '1981/1/16')
      expect(user.age).to eq 31
    end

    it '生年月日が入力されていなければnilが返って来ること' do
      user = User.new(birthday: nil)
      expect(user.age).to eq nil
    end
  end

  describe '#be_rubyist_at' do
    before do
      Timecop.travel(2015, 1, 10)
    end

    context 'Ruby歴が1年未満の場合' do
      it '0年nヶ月が返ること' do
        user = User.new(be_rubyist_at: '2014/12/31')
        year, month = user.rubyist_year_month
        expect(year).to eq 0
        expect(month).to eq 1
      end
    end

    context 'Ruby歴が1年以上の場合' do
      it 'y年mヶ月が返ること' do
        user = User.new(be_rubyist_at: '2013/11/30')
        year, month = user.rubyist_year_month
        expect(year).to eq 1
        expect(month).to eq 2
      end
    end

    context 'Ruby歴がnilの場合' do
      it 'nilが返ること' do
        user = User.new(be_rubyist_at: nil)
        year, month = user.rubyist_year_month
        expect(year).to be_blank
        expect(month).to be_blank
      end
    end
  end
end
