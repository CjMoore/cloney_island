Rails.application.routes.draw do
  root "home#index"

  resources :projects, only: [:show, :index] do
    resources :comments, only: [:create]
  end

  get      '/login', to: 'sessions#new', as: "login"
  get      '/signup', to: 'users#new'
  post     '/login', to: 'sessions#create'
  post     '/signup', to: 'users#create'

end
