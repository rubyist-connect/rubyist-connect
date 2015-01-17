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

  scenario 'ランダムにユーザーが21名表示されること' do
    100.times do
      create :user
    end

    # 3回の表示結果の比較(先頭ユーザー名)
    # ランダムなので偶然3回とも同じになる可能性あり
    first_users = []

    visit root_path
    within '.new-members' do
      imgs = all('img')
      first_users << imgs.first['alt']
      expect(imgs.size).to eq 21
    end

    visit root_path
    within '.new-members' do
      imgs = all('img')
      first_users << imgs.first['alt']
      expect(imgs.size).to eq 21
    end

    visit root_path
    within '.new-members' do
      imgs = all('img')
      first_users << imgs.first['alt']
      expect(imgs.size).to eq 21
    end

    expect(first_users.combination(2).all?{|a, b| a != b}).to be_truthy
  end
end
