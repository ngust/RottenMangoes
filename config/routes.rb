RottenMangoes::Application.routes.draw do
  
  root "sessions#new" #change later
  resources :movies do
    resources :reviews, only: [:new, :create]
  end
  resources :users, only: [:new, :create]
  resources :sessions, only: [:new, :create, :destroy]
  resources :reviews, only: [:new, :create]

end
