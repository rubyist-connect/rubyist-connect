require 'rails_helper'

feature 'New user notification' do
  given!(:alice) { create :user, :with_inactive_fields, email: 'alice@example.com' }
  given!(:bob) { create :user, :with_notification_enabled }
  given!(:chris) { create :user, :with_notification_enabled }
  given!(:davis) { create :user }

  background do
    ActionMailer::Base.deliveries.clear
    sign_in_as_new_user(alice)
    visit edit_user_path
  end

  context 'when introduction is empty' do
    scenario 'not notified' do
      check '新しいRubyistが参加したら通知メールを受け取る'
      expect { click_on '更新' }.to_not change { ActionMailer::Base.deliveries.count }
      expect(alice.reload.first_active_at).to be_blank
      expect(page).to have_content '更新しました。'
    end
  end

  context 'when introduction present' do
    scenario 'notify as bcc without the new active user only for the first time' do
      fill_in '自己紹介文', with: 'Hello!'
      check '新しいRubyistが参加したら通知メールを受け取る'
      expect(alice.first_active_at).to be_blank
      expect { click_on '更新' }.to change { ActionMailer::Base.deliveries.count }.by(1)
      expect(alice.reload.first_active_at).to be <= Time.current
      expect(page).to have_content '更新しました。'

      last_email = ActionMailer::Base.deliveries.last
      expect(last_email.subject).to eq '[Rubyist Connect-test] 新しいRubyistが登録されました！'
      expect(last_email.from).to eq ['noreply@rubyist.co']
      expect(last_email.to).to be_empty
      expect(last_email.bcc).to contain_exactly(*[bob ,chris].map(&:email))

      # Not send twice
      visit edit_user_path
      fill_in '自己紹介文', with: ''
      expect { click_on '更新' }.to_not change { ActionMailer::Base.deliveries.count }

      visit edit_user_path
      fill_in '自己紹介文', with: 'Bye.'
      expect { click_on '更新' }.to_not change { ActionMailer::Base.deliveries.count }
    end
  end

  context 'when no one is notified' do
    background do
      [bob, chris].each(&:destroy)
    end

    scenario 'not send notification' do
      fill_in '自己紹介文', with: 'Hello!'
      check '新しいRubyistが参加したら通知メールを受け取る'
      expect { click_on '更新' }.to_not change { ActionMailer::Base.deliveries.count }
    end
  end
end