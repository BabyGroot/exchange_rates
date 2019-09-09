Rails.application.routes.draw do
  resources :widgets
  get '/auth/:provider/callback', to: "sessions#google_auth"
  get 'auth/failure', to: redirect('/')
  delete 'signout', to: 'sessions#destroy', as: 'signout'

  root 'home#index', defaults: { :current_user => nil }

  resources :user do
    collection do
      get 'show'

    end
  end

  namespace :users do
    post 'calculate_exchange_rate', to: 'users#calculate_exchange_rates', as: 'calculate_exchange_rates'
  end
end
