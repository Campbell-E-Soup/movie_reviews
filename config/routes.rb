Rails.application.routes.draw do
  get "users/sign_up", to: "users#sign_up", as: "users_signup"
  get "users/logout", to: "users#logout", as: "logout"

  devise_for :users
  
  root "home#index"
end
