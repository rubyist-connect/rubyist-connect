require 'rails_helper'

feature 'Event management' do
  scenario 'イベントが管理できること' do
    users = 10.times.map{ create :user }

    sign_in_as_active_user

    # イベントを作成する
    click_on 'Event'
    click_on 'new event'
    fill_in 'Name', with: 'KRCハッカソン'
    participants = users.take(3)
    participants.each do |user|
      check user.name_or_nickname
    end
    click_on '登録する'
    expect(page).to have_content 'Event was successfully created.'

    # ユーザー一覧を表示する
    within 'h1' do
      expect(page).to have_content 'KRCハッカソン'
    end
    participants.each do |user|
      expect(page).to have_content user.name_or_nickname
    end
    (users - participants).each do |user|
      expect(page).to_not have_content user.name_or_nickname
    end

    # イベントを編集する
    click_on 'Event'
    click_on '編集'
    fill_in 'Name', with: 'KRC Hackathon'
    click_on '更新する'
    expect(page).to have_content 'Event was successfully updated.'
    within 'h1' do
      expect(page).to have_content 'KRC Hackathon'
    end

    # イベントを削除する
    click_on 'Event'
    click_on '削除'
    expect(page).to have_content 'Event was successfully destroyed.'
    expect(page).to_not have_content 'KRC Hackathon'
  end

  scenario 'activeなユーザーだけが選択できること' do
    active_users = 10.times.map{ create :user }
    inactive_users = 10.times.map{ create :inactive_user }
    sign_in_as_active_user

    click_on 'Event'
    click_on 'new event'

    active_users.each do |user|
      expect(page).to have_field user.name_or_nickname
    end

    inactive_users.each do |user|
      expect(page).to_not have_field user.name_or_nickname
    end
  end
end