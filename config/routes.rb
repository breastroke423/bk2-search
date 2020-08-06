Rails.application.routes.draw do
  get 'searchs/new'
  devise_for :users
  resources :users,only: [:show,:index,:edit,:update]
  resources :books do
    resource :favorites, only: [:create, :destroy]
    resource :post_comments,only: [:create, :destroy]
end
  resources :users do
    get 'follow' => 'users#follow', as: 'follow'
    get 'followers' => 'users#followers', as:'followers'
  end
  post 'follow/:id' => 'relationships#follow', as: 'follow' # フォローする
  post 'unfollow/:id' => 'relationships#unfollow', as: 'unfollow' # フォロー外す

  root 'home#top'
  get 'home/about'
  get 'search' => 'searches#search'
end