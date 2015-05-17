Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }
  devise_scope :user do
    delete '/users/sign_out', to: 'sessions#destroy', as: :destroy_user_session
  end

  scope 'nnect' do
    get :doorkeeper_sync, to: 'doorkeepers#sync'
    resources :events do
      resources :users, only: %i(show), param: :nickname
    end

    get '/edit', to: 'users#edit', as: :edit_user
    patch '/' => 'users#update'
    delete '/' => 'users#destroy'
    # editより必ずあとに持ってくる（editがnicknameとして扱われるため）
    resources :users, path: '', only: [:index, :show], param: :nickname
  end

  root 'top#index'
end
