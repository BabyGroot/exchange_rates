Rails.application.routes.draw do
  get '/auth/:provider/callback', to: "sessions#google_auth"
  get 'auth/failure', to: redirect('/')
  delete 'signout', to: 'sessions#destroy', as: 'signout'

  root 'home#index'

  resources :user do
    collection do
      get 'show'
    end
  end
end
