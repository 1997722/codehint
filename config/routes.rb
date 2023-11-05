Rails.application.routes.draw do
  devise_for :users
  root to: 'posts#index'
  resources :posts do
    collection do
      get 'search'
    end
  end
  resources :tags do
    get 'posts', to: 'posts#search'
  end
  resources :users
end
