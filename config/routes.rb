Rails.application.routes.draw do
  root "home#index"
  resources :dogs
  resources :inventory, controller: 'inventories', as: 'inventory'
  resources :inventory_items
  resources :users do
    patch 'set_role', on: :member, as: :set_role
    patch 'restore', on: :member, as: :restore
  end
  resource :records, only: [:show]
  resources :first_login, only: [:index, :update]

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
  # get '/first_login', to: 'admin_approval#index', as: "first_login"
  # patch '/admin_approval/:id', to: 'admin_approval#update', as: 'first_login'
  get '/dashboard', to: 'dashboard#index' 
end
