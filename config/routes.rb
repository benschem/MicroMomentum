Rails.application.routes.draw do
  devise_for :users
  root to: "home#index"
  resources :habits do
    member do
      patch :click
    end
  end
end
