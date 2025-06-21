Rails.application.routes.draw do
  get "users/logout", to: "users#logout", as: "logout"

  devise_for :users
  
  root "home#index"

  resources :users, param: :username, only: [:show]
  resources :movies, param: :name, only: [:show]
  resources :movies, only: [:index]

  resources :reviews, only: [:create] do
    collection do
      get 'compose/:name', to: 'reviews#compose', as: :compose
    end
  end

end
