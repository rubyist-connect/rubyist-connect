Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }
  devise_scope :user do
    delete '/users/sign_out', to: 'devise/sessions#destroy', as: :destroy_user_session
  end
  patch '/nnect/:id' => 'users#update'
  put '/nnect/:id' => 'users#update'
  resources :users , path: "nnect" , only: [:index, :show, :destroy], param: :nickname
  resources :interests, path: "tags" , only: [:new, :create, :index, :update, :destroy]
  get '/tag_settings' => 'interests#edit'
  get '/settings' => 'users#edit'
  root 'top#index'
end
