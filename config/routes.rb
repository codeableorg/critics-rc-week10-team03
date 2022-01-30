Rails.application.routes.draw do
  devise_for :users
  root "games#index"

  resources :games do
    resources :critics
  end

  resources :companies

  resources :companies do
    resources :critics
  end

  resources :users do
    resources :critics
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
