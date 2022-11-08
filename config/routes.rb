Rails.application.routes.draw do
  root "home#index"
  resources :dogs
  resources :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resource :session , only: [:new, :create, :destroy]
end
