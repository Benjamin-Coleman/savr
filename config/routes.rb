Rails.application.routes.draw do

  root "static#index"
  resources :ratings, only: [:new, :create]
  resources :listings

  get 'foods/:id', to: "foods#show"
  post 'bids/create', to: "bids#create"

  get 'signup', to: "users#new"
  get 'users/:id',  to: "users#show"
  post 'users/create', to: "users#create"

  get 'login', to: "sessions#new"
  post 'login', to: "sessions#create"
  delete 'logout', to: "sessions#destroy"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
