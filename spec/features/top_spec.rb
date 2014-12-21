require 'rails_helper'

feature 'Top spec' do
  scenario 'ログイン中はトップページにアクセスできない' do
    sign_in_as_new_user

    visit root_path

    expect(current_path).to eq users_path
  end
end