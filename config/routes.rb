Rails.application.routes.draw do
  patch '/nnect/:id' => 'users#update'
  put '/nnect/:id' => 'users#update'
  resources :users , path: "nnect" , only: [:index, :show, :destroy], param: :nickname
  resources :interests, path: "tags" , only: [:new, :create, :index, :update, :destroy]
  get '/auth/:provider/callback', to: 'sessions#create'
  get '/tag_settings' => 'interests#edit'
  get '/settings' => 'users#edit'
  get '/signout' => 'sessions#destroy'
  root 'top#index'
end
