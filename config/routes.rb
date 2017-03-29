Rails.application.routes.draw do
  resources :projects, only: [:show], path: ":project"
end
