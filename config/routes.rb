Rails.application.routes.draw do
  devise_for :users
  root "games#index"

  resources :games do
    resources :critics
  end

  resources :companies do
    resources :critics
  end

  resources :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
