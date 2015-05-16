require 'rails_helper'

feature 'Event user link' do
  given!(:users) do
    create_list :user, 10
  end

  context '3人のとき' do
    given(:event) { create :event, name: 'テストコード相談会' }
    given(:event_users) { users.sample(3).sort_by(&:id) }

    background do
      event.users += event_users
      sign_in_as_active_user(users.first)
    end

    scenario 'イベント参加者のリンクをたどることができる' do
      visit event_path(event)
      expect(page).to have_content 'テストコード相談会'

      click_link nil, href: event_user_path(event, event_users[0].nickname)
      expect(page).to have_content event_users[0].introduction

      expect(page).to_not have_css '.prev-user'

      # 次へ進む
      within '.next-user' do
        click_link "#{event_users[1].name_or_nickname} >>"
      end
      expect(page).to have_content event_users[1].introduction

      within '.next-user' do
        click_link "#{event_users[2].name_or_nickname} >>"
      end
      expect(page).to have_content event_users[2].introduction

      expect(page).to_not have_css '.next-user'

      # 前に戻る
      within '.prev-user' do
        click_link "<< #{event_users[1].name_or_nickname}"
      end
      expect(page).to have_content event_users[1].introduction

      within '.prev-user' do
        click_link "<< #{event_users[0].name_or_nickname}"
      end
      expect(page).to have_content event_users[0].introduction

      expect(page).to_not have_css '.prev-user'
    end
  end

  context '1人のとき' do
    # TODO 誰かお願い
  end

  context '2人のとき' do
    # TODO 誰かお願い
  end
end