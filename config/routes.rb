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
  get "movies/genre/:genre_name", to: "movies#index", as: "genre_movies"

  resources :reviews, only: [:create, :update, :show] do
    collection do
      get 'compose/:name', to: 'reviews#compose', as: :compose
      get 'edit/:name', to: 'reviews#edit_by_movie', as: :edit_by_movie
    end
  end
end
