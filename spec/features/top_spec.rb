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
    40.times do
      create :user
    end

    # 3回の表示結果の比較
    name_1st = nil
    name_2nd = nil
    name_3rd = nil

    visit root_path
    within '.new-members' do
      imgs = all('img')
      name_1st = imgs.first['alt']
      expect(imgs.size).to eq 21
    end

    visit root_path
    within '.new-members' do
      imgs = all('img')
      name_2nd = imgs.first['alt']
      expect(imgs.size).to eq 21
    end

    visit root_path
    within '.new-members' do
      imgs = all('img')
      name_3rd = imgs.first['alt']
      expect(imgs.size).to eq 21
    end

    is_same_name = (name_1st == name_2nd) && (name_2nd == name_3rd) && (name_3rd == name_1st)
    expect(is_same_name).to eq false
  end
end
