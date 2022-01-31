Rails.application.routes.draw do
  # devise_for :users
  devise_for :users, controllers: { registrations: "registrations",
                                    omniauth_callbacks: :callbacks }
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
end
