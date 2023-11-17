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
  end
  resources :tags, only: [:index]
end