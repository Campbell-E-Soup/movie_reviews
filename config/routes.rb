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

  resources :reviews, only: [:create, :update, :destroy] do
    collection do
      get 'compose/:name', action: :compose, as: :compose
      get 'edit_by_movie/:name', action: :edit_by_movie, as: :edit_by_movie
    end

    member do
      post 'delete_via_link'
    end
  end

  namespace :admin do
    get "/", to: "dashboard#index", as: :dashboard
    get "users", to: "dashboard#users"
    get "movies", to: "dashboard#movies"
    get "reviews", to: "dashboard#reviews"
    post "delete_movie/:id", to: "dashboard#delete_movie_via_link", as: :delete_movie_via_link
  end
end
