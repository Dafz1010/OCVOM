Rails.application.routes.draw do
  root "home#index"
  resources :dogs
  resources :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  get '/register', to: 'users#new'
  get '/records', to: 'records#index', as: 'records'
  get '/scan', to: 'scan#index', as: 'scan'
end
