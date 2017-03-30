Rails.application.routes.draw do

  root "home#index"
  get      '/login', to: 'sessions#new', as: "login"
  get      '/signup', to: 'users#new'
  post     '/login', to: 'sessions#create'
  post     '/signup', to: 'users#create'

end
