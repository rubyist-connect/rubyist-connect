require 'rails_helper'

feature 'Users spec' do
  scenario '自己紹介が登録されているユーザでログインした場合、ユーザの一覧ページへリダイレクトすること' do
    sign_in_as_active_user
    expect(current_path).to eq users_path
  end

  scenario 'ログイン - 登録情報変更 - ユーザ検索 - ログアウトができること' do
    Timecop.travel(2015, 2, 8, 14, 59, 30) do
      sign_in_as_new_user
    end

    expect(page).to have_content 'あなたの自己紹介を入力すると、ユーザー一覧にあなたが表示されます'
    expect(page).to have_content 'ユーザ情報の更新'

    fill_in '自己紹介文', with: 'よろしくお願いします。'
    fill_in 'Twitter ユーザ名', with: 'alice-twitter'
    fill_in 'Facebook ユーザ名', with: 'alice-facebook'
    fill_in 'Qiita ユーザ名', with: 'alice-qiita'
    fill_in '名前', with: 'ありす'

    Timecop.travel(2015, 3, 9, 15, 22, 45) do
      click_on '更新'
    end

    expect(page).to have_content "参加日時:2015/02/08 14:59"
    expect(page).to have_content "更新日時:2015/03/09 15:22"

    click_on 'Sign out'

    other_user = create :user
    sign_in_with_github(other_user)

    expect(page).to have_content 'ありす'
    expect(page).to have_content 'よろしくお願いします'
    show_link = find('.current-user-link')
    expect(show_link[:href]).to eq user_path(other_user.nickname)
    # TODO TwitterやFacebookのリンク存在チェックもしたい

    within '.navbar form' do
      fill_in 'User Search', with: 'あり'
      find('.btn').click
    end
    expect(page).to have_content 'ありす'

    within '.navbar form' do
      fill_in 'User Search', with: 'facebook'
      find('.btn').click
    end
    expect(page).to have_content 'ありす'

    within '.navbar form' do
      fill_in 'User Search', with: 'twitter'
      find('.btn').click
    end
    expect(page).to have_content 'ありす'

    within '.navbar form' do
      fill_in 'User Search', with: 'qiita'
      find('.btn').click
    end
    expect(page).to have_content 'ありす'

    within '.navbar form' do
      fill_in 'User Search', with: '12345'
      find('.btn').click
    end
    expect(page).to_not have_content 'ありす'

    click_on 'Sign out'
    expect(page).to have_content 'Rubyist は、すぐそこに'
  end
  
  scenario 'ログアウト後にアラートが出ないこと' do
    sign_in_as_new_user

    click_on 'Sign out'

    expect(page).to_not have_content 'ログアウトしました。'
  end

  scenario '退会後にアラートが出ること' do
    sign_in_as_new_user

    click_link '退会'

    expect(page).to have_content '退会しました'
  end

  scenario '退会ができること' do
    sign_in_as_new_user

    expect(page).to have_content 'ユーザ情報の更新'

    expect{click_link '退会'}.to change{User.count}.by(-1)

    expect(page).to have_content 'Rubyist は、すぐそこに'
  end

  scenario '存在しないユーザーを表示しようとした場合はNot foundとすること' do
    user = sign_in_as_new_user

    expect{visit user_path(user.nickname)}.to_not raise_error
    expect{visit user_path('Tom')}.to raise_error ActiveRecord::RecordNotFound
  end

  scenario 'activeなユーザーが表示されること' do
    inactive = create :user, :with_inactive_fields
    active = create :user
    other = create :user
    sign_in_with_github(other)

    expect(page).to have_content active.name_or_nickname
    expect(page).to_not have_content inactive.name_or_nickname
  end

  scenario 'Show/hide email field on notification enabled change', js: true do
    sign_in_as_new_user
    visit edit_user_path
    expect(page).to_not have_field '通知用メールアドレス'
    check '新しいRubyistが参加したら通知メールを受け取る'
    expect(page).to have_field '通知用メールアドレス'
    uncheck '新しいRubyistが参加したら通知メールを受け取る'
    expect(page).to_not have_field '通知用メールアドレス'

    # Keeps showing email field after validation error
    check '新しいRubyistが参加したら通知メールを受け取る'
    fill_in '通知用メールアドレス', with: ''
    click_on '更新'
    expect(page).to have_content '通知用メールアドレスを入力してください。'
    expect(page).to have_field '通知用メールアドレス'
    fill_in '通知用メールアドレス', with: 'alice@example.com'
    click_on '更新'
    expect(page).to have_content '更新しました。'

    # Shows email field on first visit
    visit edit_user_path
    expect(page).to have_field '通知用メールアドレス'
  end
end
