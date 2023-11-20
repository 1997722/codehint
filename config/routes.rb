Rails.application.routes.draw do
  devise_for :users
  root to: 'posts#index'

  get '/about', to: 'about#index'  # この行を追加

  resources :posts do
    collection do
      get 'search'
    end
    resource :likes, only: [:create, :destroy]
    resources :comments, only: :create
  end
  resources :users, only: [:index, :show] do
    member do
      get :likes
    end
    member do
      post 'follow', to: 'relationships#create' # フォローする
      delete 'unfollow', to: 'relationships#destroy' # フォロー解除する
    end
  end
  resources :tags, only: [:index]
  
end