Rails.application.routes.draw do
  devise_for :users
  root to: 'posts#index'
  resources :posts do
    collection do
      get 'search'
    end
    resource :likes, only: [:create, :destroy]
  end
  resources :users do
    member do
      get :likes
    end
  end
end