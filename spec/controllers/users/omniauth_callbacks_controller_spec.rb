require 'rails_helper'

RSpec.describe Users::OmniauthCallbacksController, type: :controller do
  describe 'GET github' do
    before do
      # Devise の機能を直接呼ぶために必要
      # https://github.com/plataformatec/devise#test-helpers
      @request.env['devise.mapping'] = Devise.mappings[:user]

      # FactoryGirl から返る Hash の key を String に変換して stub
      @auth_hash = build(:omniauth_hash).map { |k, v| [k.to_s, v] }.to_h
      expect(controller).to receive(:auth_hash).and_return(@auth_hash)
    end

    subject do
      get :github
    end

    context '新規ユーザの場合' do
      it 'User が 1 件増える' do
        expect { subject }.to change(User, :count).by(1)
      end

      it 'ユーザ編集画面にリダイレクトする' do
        expect(subject).to redirect_to(edit_user_path(@auth_hash['info']['nickname'], format: ''))
      end
    end

    context '既存ユーザの場合' do
      it 'プロフィールが未入力の場合、ユーザ編集画面にリダイレクトする' do
        create(:inactive_user, github_id: @auth_hash['uid'])
        expect(subject).to redirect_to(edit_user_path(@auth_hash['info']['nickname'], format: ''))
      end

      it 'プロフィールが入力済みの場合、ユーザ詳細画面にリダイレクトする' do
        create(:user, github_id: @auth_hash['uid'])
        expect(subject).to redirect_to(root_path)
      end
    end
  end
end
