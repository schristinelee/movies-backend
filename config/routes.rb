Rails.application.routes.draw do
  resources :movies
  resources :favorites

  post "/users" => "users#create"
  post "/sessions" => "sessions#create"

  get "/users" => "users#index"
end
