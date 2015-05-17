require 'rails_helper'

feature 'Doorkeeper sync' do
  given(:login_user) { create :user }

  scenario 'Doorkeeperの情報をフォームに反映させる', js: true do
    sign_in_as_active_user(login_user)
    VCR.use_cassette 'models/doorkeeper_api_spec/fetch_event_details', match_requests_on: [:uri] do
      visit new_event_path
      fill_in 'Url', with: 'https://nishiwaki-koberb.doorkeeper.jp/events/24544'
      click_on 'Doorkeeper Sync'
      expect(page).to have_field 'Name', with: 'Rubyistのためのテストコード相談会 ～テストの書き方に悩んでいませんか？～'
    end
  end
end