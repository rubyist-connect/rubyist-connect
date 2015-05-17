require 'rails_helper'

feature 'Doorkeeper sync' do
  given(:login_user) { create :user }

  scenario 'Doorkeeperの情報をフォームに反映させる', js: true do
    sign_in_as_active_user(login_user)
    visit new_event_path
    fill_in 'Url', with: 'https://nishiwaki-koberb.doorkeeper.jp/events/24544'
    click_on 'Doorkeeper Sync'
    expect(page).to have_field 'Name', with: 'Rubyistのためのテストコード相談会 ～テストの書き方に悩んでいませんか？～'
  end
end