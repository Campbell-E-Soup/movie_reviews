Rails.application.routes.draw do
  get "users/signin"
  get "users/signup"
  post "users/signin"
  post "users/signup"

  devise_for :users
  
  root "home#index"
end
