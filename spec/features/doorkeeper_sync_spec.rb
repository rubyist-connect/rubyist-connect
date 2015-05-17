require 'rails_helper'

feature 'Doorkeeper sync' do
  given(:login_user) { create :user }
  context '完全一致する場合' do
    given!(:yuji_shimoda) { create :user, name: 'Yuji Shimoda', nickname: 'yuji-shimoda' }
    given!(:ito) { create :user, name: '伊藤淳一', nickname: 'JunichiIto', twitter_name: 'jnchito' }
    given!(:hara) { create :user, name: '原孝道', nickname: 'takamiy', facebook_name: 'takamichi.hara' }
    given!(:aki) { create :user, name: 'Aki ', nickname: 'springaki' }
    given!(:otokunaga) { create :user, name: 'とくなが', nickname: 'otokunaga' }

    scenario 'Doorkeeperの情報をフォームに反映させる', js: true do
      sign_in_as_active_user(login_user)
      VCR.use_cassette 'doorkeeper_events/24544_test_code_discussion', match_requests_on: [:uri] do
        visit new_event_path
        fill_in 'Url', with: 'https://nishiwaki-koberb.doorkeeper.jp/events/24544'
        click_on 'Doorkeeper Sync'
        expect(page).to have_field 'Name', with: 'Rubyistのためのテストコード相談会 ～テストの書き方に悩んでいませんか？～'

        expect(find("#event_user_ids_#{yuji_shimoda.id}")).to be_checked
        expect(find("#event_user_ids_#{ito.id}")).to be_checked
        expect(find("#event_user_ids_#{hara.id}")).to be_checked
        expect(find("#event_user_ids_#{aki.id}")).to be_checked
        expect(find("#event_user_ids_#{otokunaga.id}")).to be_checked
        expect(find("#event_user_ids_#{login_user.id}")).to_not be_checked
      end
    end
  end

  context '大文字小文字の違いやスペースの有無がある場合' do
    given!(:yuji_shimoda) { create :user, name: 'Yuji Shimoda', nickname: 'Yuji-shimoda' }
    given!(:ito) { create :user, name: '伊藤淳一', nickname: 'JunichiIto', twitter_name: 'Jnchito' }
    given!(:hara) { create :user, name: '原孝道', nickname: 'takamiy', facebook_name: 'Takamichi.hara' }
    given!(:aki) { create :user, name: 'Aki', nickname: 'springaki' }
    given!(:otokunaga) { create :user, name: 'とくなが', nickname: 'Otokunaga' }

    scenario '微妙な違いは無視して選択する', js: true do
      sign_in_as_active_user(login_user)
      VCR.use_cassette 'doorkeeper_events/24544_test_code_discussion', match_requests_on: [:uri] do
        visit new_event_path
        fill_in 'Url', with: 'https://nishiwaki-koberb.doorkeeper.jp/events/24544'
        click_on 'Doorkeeper Sync'
        expect(page).to have_field 'Name', with: 'Rubyistのためのテストコード相談会 ～テストの書き方に悩んでいませんか？～'

        expect(find("#event_user_ids_#{yuji_shimoda.id}")).to be_checked
        expect(find("#event_user_ids_#{ito.id}")).to be_checked
        expect(find("#event_user_ids_#{hara.id}")).to be_checked
        expect(find("#event_user_ids_#{aki.id}")).to be_checked
        expect(find("#event_user_ids_#{otokunaga.id}")).to be_checked
        expect(find("#event_user_ids_#{login_user.id}")).to_not be_checked
      end
    end
  end
end