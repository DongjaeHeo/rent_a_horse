Rails.application.routes.draw do
  devise_for :users
  root to: "horses#index"
  resources :horses do
    resources :bookings, except: [:destroy]
  end
  resources :bookings, only: [:destroy]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
