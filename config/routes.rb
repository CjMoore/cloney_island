Rails.application.routes.draw do
  root "home#index"

  resources :projects, only: [:show, :index] do
    resources :comments, only: [:create]
  end

  resources :user_funded_projects, only: [:create]
  
  get      '/login',  to: 'sessions#new', as: "login"
  get      '/signup', to: 'users#new'
  post     '/login',  to: 'sessions#create'
  delete   '/logout', to: 'sessions#destroy'
  post     '/signup', to: 'users#create'
  get      '/funds',  to: 'user_funded_projects#new'

end
