Rails.application.routes.draw do
  get '/auth/:provider/callback', to: "sessions#google_auth"
  get 'auth/failure', to: redirect('/')
  delete 'signout', to: 'sessions#destroy', as: 'signout'
  post 'calculate_exchange_rates', to: 'user#calculate_exchange_rates'

  root 'home#index', defaults: { :current_user => nil }

  resources :user do
    collection do
      get 'show'
    end
  end
end
