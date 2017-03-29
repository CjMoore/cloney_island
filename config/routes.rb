Rails.application.routes.draw do
  root "home#index"

  resources :projects, only: [:show]

  get      '/login', to: 'sessions#new', as: "login"
  get      '/signup', to: 'users#new'
  post     '/login', to: 'sessions#create'
end
