require 'rails_helper'

feature 'Top spec' do
  scenario 'ログイン中はトップページにアクセスできない' do
    sign_in_as_new_user

    visit root_path

    expect(current_path).to eq users_path
  end

  scenario 'activeなユーザーが表示されること' do
    create :inactive_user
    active = create :user
    visit root_path
    within '.new-members' do
      imgs = all('img')
      expect(imgs.size).to eq 1
      expect(imgs.first['alt']).to eq active.name
    end
  end
end