require 'rails_helper'

feature 'Doorkeeper sync', js: true do
  given(:login_user) { create :user }

  background do
    sign_in_as_active_user(login_user)
  end

  context '完全一致する場合' do
    given!(:yuji_shimoda) { create :user, name: 'Yuji Shimoda', nickname: 'yuji-shimoda' }
    given!(:ito) { create :user, name: '伊藤淳一', nickname: 'JunichiIto', twitter_name: 'jnchito' }
    given!(:hara) { create :user, name: '原孝道', nickname: 'takamiy' }
    given!(:aki) { create :user, name: 'Aki ', nickname: 'springaki' }
    given!(:otokunaga) { create :user, name: 'Seiki Tokunaga', nickname: 'otokunaga2' }

    scenario 'Doorkeeperの情報をフォームに反映させる' do
      VCR.use_cassette 'doorkeeper_events/24544_test_code_discussion', match_requests_on: [:uri] do
        visit new_event_path
        fill_in 'Url', with: 'https://nishiwaki-koberb.doorkeeper.jp/events/24544'
        click_on 'Event Sync'
        expect(page).to have_field 'Name', with: 'Rubyistのためのテストコード相談会 ～テストの書き方に悩んでいませんか？～'

        expect(find("#event_user_ids_#{yuji_shimoda.id}")).to be_checked
        expect(find("#event_user_ids_#{ito.id}")).to be_checked
        expect(find("#event_user_ids_#{hara.id}")).to be_checked
        expect(find("#event_user_ids_#{aki.id}")).to be_checked
        expect(find("#event_user_ids_#{otokunaga.id}")).to be_checked
        expect(find("#event_user_ids_#{login_user.id}")).to_not be_checked

        expect(page).to have_selector '.event-sync-status', text: '情報を取得しました。'
        expect(page).to have_css '.event-sync-status.result-success'
        expect(page).to have_css '.result-icon-success'
        expect(page).to_not have_css '.img-loading'

        # httpでSyncする
        visit new_event_path
        fill_in 'Url', with: 'http://nishiwaki-koberb.doorkeeper.jp/events/24544'
        click_on 'Event Sync'
        expect(page).to have_selector '.event-sync-status', text: '情報を取得しました。'
      end
    end
  end

  context '大文字小文字の違いやスペースの有無がある場合' do
    given!(:yuji_shimoda) { create :user, name: 'Yuji Shimoda', nickname: 'Yuji-shimoda' }
    given!(:ito) { create :user, name: '伊藤淳一', nickname: 'JunichiIto', twitter_name: 'Jnchito' }
    given!(:hara) { create :user, name: '原孝道', nickname: 'takamiy' }
    given!(:aki) { create :user, name: 'Aki', nickname: 'springaki' }
    given!(:otokunaga) { create :user, name: 'Seiki Tokunaga', nickname: 'Otokunaga2' }

    scenario '微妙な違いは無視して選択する' do
      VCR.use_cassette 'doorkeeper_events/24544_test_code_discussion', match_requests_on: [:uri] do
        visit new_event_path
        fill_in 'Url', with: 'https://nishiwaki-koberb.doorkeeper.jp/events/24544'
        click_on 'Event Sync'
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

  context '条件に合致するユーザーが2名以上見つかった場合' do
    given!(:yuji_shimoda) { create :user, name: 'Yuji Shimoda', nickname: 'yuji-shimoda' }
    given!(:yuji_shimoda2) { create :user, name: 'Yuji Shimoda', nickname: 'yuji-shimoda2' }
    given!(:ito) { create :user, name: '伊藤淳一', nickname: 'JunichiIto', twitter_name: 'jnchito' }
    given!(:hara) { create :user, name: '原孝道', nickname: 'takamiy' }
    given!(:aki) { create :user, name: 'Aki ', nickname: 'springaki' }
    given!(:otokunaga) { create :user, name: 'Seiki Tokunaga', nickname: 'otokunaga2' }

    scenario '違うユーザーを選択する可能性があるので、選択しない' do
      VCR.use_cassette 'doorkeeper_events/24544_test_code_discussion', match_requests_on: [:uri] do
        visit new_event_path
        fill_in 'Url', with: 'https://nishiwaki-koberb.doorkeeper.jp/events/24544'
        click_on 'Event Sync'
        expect(page).to have_field 'Name', with: 'Rubyistのためのテストコード相談会 ～テストの書き方に悩んでいませんか？～'

        expect(find("#event_user_ids_#{yuji_shimoda.id}")).to_not be_checked
        expect(find("#event_user_ids_#{yuji_shimoda2.id}")).to_not be_checked
        expect(find("#event_user_ids_#{ito.id}")).to be_checked
        expect(find("#event_user_ids_#{hara.id}")).to be_checked
        expect(find("#event_user_ids_#{aki.id}")).to be_checked
        expect(find("#event_user_ids_#{otokunaga.id}")).to be_checked
        expect(find("#event_user_ids_#{login_user.id}")).to_not be_checked
      end
    end
  end

  context 'activeではないユーザーが含まれている場合' do
    given!(:yuji_shimoda) { create :user, name: 'Yuji Shimoda', nickname: 'Yuji-shimoda', introduction: '' }
    given!(:ito) { create :user, name: '伊藤淳一', nickname: 'JunichiIto', twitter_name: 'Jnchito' }

    scenario 'activeなユーザーだけを選択する' do
      VCR.use_cassette 'doorkeeper_events/24544_test_code_discussion', match_requests_on: [:uri] do
        visit new_event_path
        fill_in 'Url', with: 'https://nishiwaki-koberb.doorkeeper.jp/events/24544'
        click_on 'Event Sync'
        expect(page).to have_field 'Name', with: 'Rubyistのためのテストコード相談会 ～テストの書き方に悩んでいませんか？～'

        expect(page).to_not have_css "#event_user_ids_#{yuji_shimoda.id}"
        expect(find("#event_user_ids_#{ito.id}")).to be_checked
      end
    end
  end

  context '存在しないイベントの場合' do
    scenario 'エラーメッセージを表示する' do
      VCR.use_cassette 'doorkeeper_events/1_not_found', match_requests_on: [:uri] do
        visit new_event_path
        fill_in 'Url', with: 'https://nishiwaki-koberb.doorkeeper.jp/events/1'
        click_on 'Event Sync'
        expect(page).to have_selector '.event-sync-status', text: 'イベントが見つかりません。URLを確認してください。'
        expect(page).to have_css '.event-sync-status.result-error'
        expect(page).to have_css '.result-icon-error'
        expect(page).to_not have_css '.img-loading'
      end
    end
  end

  context '予期せぬエラーが発生した場合' do
    scenario 'エラーメッセージを表示する' do
      allow_any_instance_of(DoorkeeperApi).to receive(:fetch_event_details).and_return({'status' => 'ERROR'})
      visit new_event_path
      fill_in 'Url', with: 'https://nishiwaki-koberb.doorkeeper.jp/events/24544'
      click_on 'Event Sync'
      expect(page).to have_selector '.event-sync-status', text: 'エラーが発生しました。しばらく経ってから再度実行してください。'
      expect(page).to have_css '.event-sync-status.result-error'
      expect(page).to have_css '.result-icon-error'
      expect(page).to_not have_css '.img-loading'
    end
  end

  feature 'ボタンの有効制御' do
    context '新規作成画面' do
      scenario '適切に制御される' do
        visit new_event_path
        expect(page).to have_css '.link-event-sync.disabled'

        fill_in 'Url', with: 'https://nishiwaki-koberb.doorkeeper.jp/events/24544'
        expect(page).to_not have_css '.link-event-sync.disabled'

        fill_in 'Url', with: 'https://nishiwaki-koberb.doorkeeper.jp/events'
        expect(page).to have_css '.link-event-sync.disabled'

        fill_in 'Url', with: 'http://koberb.doorkeeper.jp/events/24880'
        expect(page).to_not have_css '.link-event-sync.disabled'
      end
    end
    context '編集画面' do
      given(:event) { create :event, url: url }
      background do
        visit edit_event_path(event)
      end
      context '未入力' do
        given(:url) { '' }
        scenario '無効になっている' do
          expect(page).to have_css '.link-event-sync.disabled'
        end
      end
      context 'DoorkeeperのURL' do
        given(:url) { 'https://nishiwaki-koberb.doorkeeper.jp/events/24544' }
        scenario '有効になっている' do
          expect(page).to_not have_css '.link-event-sync.disabled'
        end
      end
      context '無効なURL' do
        given(:url) { 'https://nishiwaki-koberb.doorkeeper.jp/events' }
        scenario '無効になっている' do
          expect(page).to have_css '.link-event-sync.disabled'
        end
      end
    end
  end
end
