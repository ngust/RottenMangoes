RottenMangoes::Application.routes.draw do
  get "users/new"
  get "users/create"
  resources :movies
end
