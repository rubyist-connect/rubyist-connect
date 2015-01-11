require 'rails_helper'

feature 'Tags spec' do
  scenario 'タグの管理ができること' do
    sign_in_as_new_user

    find('.settings-link').click

    fill_in '自己紹介文', with: 'よろしくお願いします。'
    fill_in 'Twitter ユーザ名', with: 'alice-twitter'
    fill_in 'Facebook ユーザ名', with: 'alice-facebook'
    fill_in 'Qiita ユーザ名', with: 'alice-qiita'
    fill_in '名前', with: 'ありす'
    click_on '更新'

    find('.settings-link').click

    click_on 'タグ作成'

    fill_in 'タグ（任意の文字列）', with: 'Qiita'
    fill_in 'タグに対するURL（あれば）', with: 'http://qiita.com/'

    click_on '更新'

    expect(page).to have_content 'タグ一覧'
    expect(page).to have_content 'Qiita'
    expect(page).to have_content 'http://qiita.com/'

    within '.navbar' do
      click_on 'Kobe Rubyist Connect'
    end

    within '.user-image' do
      find('a').click
    end

    within '.interests' do
      expect(page).to have_content 'Qiita'
    end

    click_on 'タグ一覧'

    click_on 'タグの編集'

    fill_in 'タグ（任意の文字列）', with: 'QIITA'
    fill_in 'タグに対するURL（あれば）', with: ''

    click_on '更新'

    expect(page).to have_content 'タグ一覧'
    expect(page).to have_content 'QIITA'
    expect(page).to_not have_content 'http://qiita.com/'

    click_on 'タグの削除'

    expect(page).to have_content 'タグ一覧'
    expect(page).to_not have_content 'QIITA'
  end
end