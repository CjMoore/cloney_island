Rails.application.routes.draw do
  root "home#index"

  resources :projects, only: [:show, :index, :new, :create, :update] do
    resources :comments, only: [:create]
    resources :user_funded_projects, only: [:create]
    resources :user_owned_projects, only: [:create]
    get      '/funds',  to: 'user_funded_projects#new'
    get      '/edit', to: 'projects#edit'
    post     '/edit', to: 'projects#update'
    post '/update', to: 'projects#update_status'
  end


  post    "/projects/new", to: 'projects#create'


  get      '/login',    to: 'sessions#new', as: "login"
  get      '/signup',   to: 'users#new'
  get      '/users',   to: 'users#index'
  post     '/login',    to: 'sessions#create'
  delete   '/logout',   to: 'sessions#destroy'
  post     '/signup',   to: 'users#create'
  get      '/username/edit', path: ':username/edit', to: 'users#edit'
  get      '/username', path: ':username',  to: 'users#show'
  patch    '/username/update', path: ':username', to: 'users#update'
  get      '/username/update_password', path: ':username/update_password', to: "users#update_password"

end
