Rails.application.routes.draw do
  devise_for :users
  resources :users,only: [:show,:index,:edit,:update]
  resources :books do
    resource :favorites, only: [:create, :destroy]
    resource :post_comments,only: [:create, :destroy]
end
  resources :users do
    member do
      get :follow, :followers
    end
  end
  post 'follow/:id' => 'relationships#follow', as: 'follow' # フォローする
  post 'unfollow/:id' => 'relationships#unfollow', as: 'unfollow' # フォロー外す

  root 'home#top'
  get 'home/about'
  get 'users/:id/follow' => 'users#follow'
  get 'users/:id/followers' => 'users#followers'
end