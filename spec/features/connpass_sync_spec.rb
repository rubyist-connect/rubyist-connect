require 'rails_helper'

feature 'Connpass sync', js: true do
  given(:login_user) { create :user }

  background do
    sign_in_as_active_user(login_user)
  end

  context '完全一致する場合' do
    # nameが一致
    given!(:akira_noguchi) { create :user, name: 'akira-noguchi', nickname: 'nodic' }
    # nickname(github)が一致
    given!(:gu_code) { create :user, name: 'Foo', nickname: 'GuCode' }
    # twitterが一致
    given!(:djokov07) { create :user, name: 'Bar', nickname: 'bar', twitter_name: 'Djokov07' }
    # facebookが一致
    given!(:kobayashi_shoji) { create :user, name: 'Kobayashi Shoji', nickname: 'baz', facebook_name: '883815278321042' }
    # 何も一致しない
    given!(:otokunaga) { create :user, name: 'とくなが', nickname: 'otokunaga' }

    scenario 'Doorkeeperの情報をフォームに反映させる' do
      VCR.use_cassette 'connpass_events/39406', match_requests_on: [:uri] do
        visit new_event_path
        fill_in 'Url', with: 'http://connpass.com/event/39406/'
        click_on 'Event Sync'
        expect(page).to have_field 'Name', with: 'もくもく会＃８'

        expect(find("#event_user_ids_#{akira_noguchi.id}")).to be_checked
        expect(find("#event_user_ids_#{gu_code.id}")).to be_checked
        expect(find("#event_user_ids_#{djokov07.id}")).to be_checked
        expect(find("#event_user_ids_#{kobayashi_shoji.id}")).to be_checked
        expect(find("#event_user_ids_#{otokunaga.id}")).to_not be_checked
        expect(find("#event_user_ids_#{login_user.id}")).to_not be_checked

        expect(page).to have_selector '.event-sync-status', text: '情報を取得しました。'
        expect(page).to have_css '.event-sync-status.result-success'
        expect(page).to have_css '.result-icon-success'
        expect(page).to_not have_css '.img-loading'
      end
    end
  end
end
