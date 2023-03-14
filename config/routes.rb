Rails.application.routes.draw do
  devise_for :users
  root to: "horses#index"
  resources :horses do
    resources :bookings, except: [:destroy] do
      member do
        get 'confirm', to: 'bookings#confirm'
      end
    end
  end
  resources :bookings, only: [:destroy]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  # show individual bookings
  get '/dashboard', to: 'dashboards#show', as: 'dashboard'
end
