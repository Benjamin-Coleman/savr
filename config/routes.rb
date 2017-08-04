Rails.application.routes.draw do

  delete 'listings/:id', to: 'listings#destroy', as: 'delete_listing'

  root "static#index"
  resources :ratings, only: [:new, :create]
  resources :listings do
    resources :bids
  end

  get 'foods/:id', to: "foods#show"
  post 'bids/create', to: "bids#create", as: 'new_bid'

  get 'signup', to: "users#new"
  get 'users/:id',  to: "users#show", as: 'user'
  post 'users/create', to: "users#create"
  patch 'users/:id', to: "users#update", as: 'user_update'
  get 'users/:id/edit', to: "users#edit", as: 'user_edit'

  get 'login', to: "sessions#new"
  post 'login', to: "sessions#create"
  delete 'logout', to: "sessions#destroy"

  patch 'accept', to: "bids#accept"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
