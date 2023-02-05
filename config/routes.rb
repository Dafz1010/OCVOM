Rails.application.routes.draw do
  root "home#index"
  resources :dogs
  resources :users
  resource :records, only: [:show]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  
  # Defines the root path route ("/")
  # root "articles#index"
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  get '/register', to: 'users#new'  
  get '/scan', to: 'scan#index', as: 'scan'
  get '/data_export', to: 'data_export#index'
  get 'data_export/download_report'
  get '/admin_approval', to: 'admin_approval#index'
  get '/dashboard', to: 'dashboard#index' 
end
