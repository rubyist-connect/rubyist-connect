require 'rails_helper'

feature 'Users spec' do
  given(:oauth_params) do
    params = {}
    params['provider'] = 'github'
    params['uid'] = '123'
    info = params['info'] = {}
    info['name'] = 'alice'
    info['image'] = 'https://avatars.githubusercontent.com/u/1148320?v=2'
    info['email'] = 'alice@example.com'
    info['nickname'] = 'Alice-chan'
    info['location'] = 'Kobe'
    urls = info['urls'] = {}
    urls['GitHub'] = 'https://github.com/alice-foo-bar'
    urls['Blog'] = 'http://blog.example.com'

    params
  end

  scenario 'ログイン - 登録情報変更 - ユーザ検索 - ログアウトができること' do
    visit root_path
    expect(page).to have_content '神戸の Rubyist を繋げたいという想いから生まれました。'

    # TODO あとでMacro化する
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new(oauth_params)

    click_on 'GitHub Login'
    expect(page).to have_content 'alice'

    find('.settings-link').click

    fill_in '自己紹介文', with: 'よろしくお願いします。'
    fill_in 'Twitter ユーザ名', with: 'alice'
    fill_in 'Facebook ユーザ名', with: 'alice-12345'
    fill_in '名前', with: 'ありす'
    click_on '更新'

    expect(page).to have_content 'ありす'
    expect(page).to have_content 'よろしくお願いします'
    # TODO TwitterやFacebookのリンク存在チェックもしたい

    within '.navbar form' do
      fill_in 'User Search', with: 'あり'
      find('.btn').click
    end
    expect(page).to have_content 'ありす'

    within '.navbar form' do
      fill_in 'User Search', with: '12345'
      find('.btn').click
    end
    expect(page).to_not have_content 'ありす'

    click_on 'Sign out'
    expect(page).to have_content '神戸の Rubyist を繋げたいという想いから生まれました。'
  end
end