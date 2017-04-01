Rails.application.routes.draw do
  root "home#index"

  resources :projects, only: [:show, :index, :new, :create] do
    resources :comments, only: [:create]
    resources :user_funded_projects, only: [:create]
    get      '/funds',  to: 'user_funded_projects#new'
  end

  get      '/login',    to: 'sessions#new', as: "login"
  get      '/signup',   to: 'users#new'
  post     '/login',    to: 'sessions#create'
  delete   '/logout',   to: 'sessions#destroy'
  post     '/signup',   to: 'users#create'
  get      '/username', path: ':username',  to: 'users#show'
  get      '/username/edit', path: ':username/edit', to: 'users#edit'

end
