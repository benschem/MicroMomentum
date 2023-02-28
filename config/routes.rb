Rails.application.routes.draw do
  devise_for :users
  root to: "home#index"
  resources :habits
  # get "habits", to: "habits#index"
  # get "habits/new", to: "habits#new", as: :new_habit
  # post "habits", to: "habits#create"
  # get "habits/:id", to: "habits#show", as: :habit
  # get "habits/:id/edit", to: "habits#edit", as: :edit_habit
  # patch "habits/:id", to: "habits#update"
  # delete "habits/:id", to: "habits#destroy"
end
