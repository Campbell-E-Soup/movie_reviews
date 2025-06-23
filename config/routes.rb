Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  get "users/logout", to: "users#logout", as: "logout"
  
  root "home#index"

  # resources :users, param: :username, only: [:show]
  resources :users, param: :username, only: [:show] do
    patch :update_profile_picture, on: :member
  end
  resources :movies, param: :name, only: [:show]
  resources :movies, only: [:index]

  resources :reviews, only: [:create] do
    collection do
      get 'compose/:name', to: 'reviews#compose', as: :compose
    end
  end
end
