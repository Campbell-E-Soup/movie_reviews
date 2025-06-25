Rails.application.routes.draw do
  # I seem to have deleted a JS file that allows for delete requests for buttons generated with ruby so no DELETE requests... I know what they are and how to use them but I am tired...
  devise_for :users, controllers: {
    sessions: "users/sessions",
    registrations: "users/registrations"
  }

  get "users/logout", to: "users#logout", as: "logout"

  root "home#index"

  # resources :users, param: :username, only: [:show]
  resources :users, param: :username, only: [ :show ] do
    patch :update_profile_picture, on: :member
  end
  resources :movies, param: :name, only: [ :show ]
  resources :movies, only: [ :index ]
  get "movies/genre/:genre_name", to: "movies#index", as: "genre_movies"

  resources :reviews, only: [ :create, :update, :destroy ] do
    collection do
      get "compose/:name", action: :compose, as: :compose
      get "edit_by_movie/:name", action: :edit_by_movie, as: :edit_by_movie
    end

    member do
      post "delete_via_link"
    end
  end

  namespace :admin do
    get "/", to: "dashboard#index", as: :dashboard
    get "users", to: "dashboard#users"

    get "movies", to: "dashboard#movies"
    post "movies", to: "dashboard#create_movie", as: :create_movie

    get "reviews", to: "dashboard#reviews"

    post "delete_movie/:id", to: "dashboard#delete_movie_via_link", as: :delete_movie_via_link
    post "update_movie/:name", to: "dashboard#update_movie", as: :update_movie

    post "users/:username/delete_profile_picture", to: "dashboard#delete_profile_picture", as: :delete_profile_picture
    post "users/:username/delete_account", to: "dashboard#destroy_user", as: :delete_account
  end
end
