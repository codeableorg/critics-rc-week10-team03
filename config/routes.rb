Rails.application.routes.draw do
  devise_for :users
  root "games#index"

  resources :games do
    resources :critics
    resources :genres
    resources :platforms
    resources :involved_companies
  end

  resources :companies

  resources :companies do
    resources :critics
  end

  resources :users do
    resources :critics
  end
  
  # post "/add", to: "genres#add"
end
